import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/components/elements/text_button.dart';
import 'package:gimig_gastro_application/components/messages/message1.dart';
import 'package:gimig_gastro_application/dialogs/pay_dialog.dart';
import 'package:gimig_gastro_application/functions/table_number_storage.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/objects/category_example.dart';
import 'package:gimig_gastro_application/screens/account/settings_screen.dart';
import 'package:gimig_gastro_application/screens/cart_screen.dart';
import 'package:gimig_gastro_application/screens/overview_screen.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  final TableNumberStorage storage = TableNumberStorage();
  WelcomeScreen({this.name});
  String name;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Firestore _firestore = Firestore.instance;
  int tableNumber;
  String status;
  String tableMessage;

  Future<void> showMessage() async {
    await showDialog(
      context: context,
      builder: (_) => Message1(),
    );
  }

  Future<String> getStatus() async {
    await widget.storage.readTableNumber().then((int value) {
      setState(() {
        tableNumber = value;
      });
    });
    print("Tablenumber $tableNumber");
    var snapshot = await Firestore.instance
        .collection('restaurants')
        .document('venezia')
        .collection('tables')
        .document("$tableNumber")
        .get();

    status = snapshot.data["status"];
    print("STATUS: $status");
    return status;
  }

  @override
  void initState() {
    super.initState();
    widget.storage.readTableNumber().then((int value) {
      setState(() {
        tableNumber = value;
      });
    });
    getStatus();

    // Stream<QuerySnapshot> messageStream() {
    //   _firestore
    //       .collection('restaurants')
    //       .document('venezia')
    //       .collection('tables')
    //       .document("$tableNumber")
    //       .collection("messages")
    //       .snapshots().map((snapshot) {
    //         if(snapshot.documents.
    //   });
    // }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: kBackgroundColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection("restaurants")
            .document("venezia")
            .collection("tables")
            .document("$tableNumber")
            .collection("messages")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.orangeAccent,
              ),
            );
          }
          final item = snapshot.data.documents;

          for (var item in item) {
            final message = item.data['message'];
            final state = item.data['state'];

            if (message == "message1") {
              tableMessage = message;
              print(message);
            }
          }

          return Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/BackgroundImage.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Icon(
                      Icons.notifications_active,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CartScreen.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 700,
                      child: GestureDetector(
                        onDoubleTap: () {
                          Navigator.pushNamed(context, SettingsScreen.id);
                        },
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Willkommen bei",
                                  style: kMainTitleTextStyle),
                              TextSpan(
                                  text: " Venezia",
                                  style: kMainTitleTextStyle.copyWith(
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        CustomTextButton(
                          textSize: 25,
                          buttonHeigt: 55,
                          buttonText: "Getränke",
                          buttonAction: () {
                            Navigator.of(context).pushNamed(OverviewScreen.id,
                                arguments: beverages);
                          },
                        ),
                        SizedBox(height: 20),
                        CustomTextButton(
                          textSize: 25,
                          buttonHeigt: 55,
                          buttonText: "Speisen",
                          buttonAction: () {
                            Navigator.of(context).pushNamed(
                              OverviewScreen.id,
                              arguments: courses,
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        if (status == "ordered" || status == "accepted")
                          CustomTextButton(
                            textSize: 25,
                            buttonHeigt: 55,
                            buttonText: "Zahlen",
                            buttonAction: () {
                              showDialog(
                                context: context,
                                builder: (_) =>
                                    PayDialog(tableNumber: tableNumber),
                              );
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
