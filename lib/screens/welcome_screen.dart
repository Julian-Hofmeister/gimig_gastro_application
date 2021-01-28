import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/components/elements/text_button.dart';
import 'package:gimig_gastro_application/components/messages/message1.dart';
import 'package:gimig_gastro_application/dialogs/bell_dialog.dart';
import 'package:gimig_gastro_application/dialogs/pay_dialog.dart';
import 'package:gimig_gastro_application/services/connection_service.dart';
import 'package:gimig_gastro_application/services/table_number_storage.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/main/screen_arguments.dart';
import 'package:gimig_gastro_application/screens/account/settings_screen.dart';
import 'package:gimig_gastro_application/screens/cart_screen.dart';
import 'package:gimig_gastro_application/screens/category_screen_connected.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  final TableNumberStorageService storage = TableNumberStorageService();
  WelcomeScreen({this.name});
  final String name;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  DocumentReference _firestore = FirebaseFirestore.instance
      .collection("restaurants")
      .doc("${FirebaseAuth.instance.currentUser.email}");

  String tableMessage;
  int tableNumber;
  String status;
  bool ableToPay;

  Future<void> checkMessage({documentID}) async {
    await _firestore
        .collection("tables")
        .doc("$tableNumber")
        .collection("messages")
        .doc("$documentID")
        .update({"state": true});
    showMessage();

    print("MESSAGE:");
  }

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
    var snapshot =
        await _firestore.collection('tables').doc("$tableNumber").get();

    status = snapshot.data()["status"];
    print("STATUS: $status");
    return status;
  }

  @override
  void initState() {
    super.initState();
    listenToConnection(context);
    widget.storage.readTableNumber().then((int value) {
      setState(() {
        tableNumber = value;
      });
    });
    getStatus();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: kBackgroundColor,
      body: StreamBuilder<QuerySnapshot>(
        //STREAM
        stream: _firestore
            .collection("tables")
            .doc("$tableNumber")
            .collection("messages")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final messages = snapshot.data.docs;

          //LISTEN TO MESSAGES
          for (var document in messages) {
            final documentID = document.id;
            final message = document.data()['message'];
            final state = document.data()['state'];

            if (message == "message1" && state != true) {
              tableMessage = message;
              print(message);
              checkMessage(documentID: documentID);
            }
          }

          return StreamBuilder<QuerySnapshot>(
            //STREAM
            stream: _firestore.collection("tables").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final calls = snapshot.data.docs;

              //LISTEN TO TABLE
              for (var document in calls) {
                final documentID = document.id;
                final tableStatus = document.data()['status'];
                var tableAbleToPay = document.data()['ableToPay'];

                // CHECK STATUS
                if (documentID == tableNumber.toString()) {
                  print("TABLE: $documentID STATUS: $tableStatus");
                  status = tableStatus;
                }

                //CHECK ABLE TO PAY
                if (documentID == tableNumber.toString() &&
                    tableAbleToPay == true) {
                  print(
                      "TABLE: $documentID ABLETOPAY: ${tableAbleToPay.toString()}");
                  ableToPay = tableAbleToPay;
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
                            BoxDecoration(color: Colors.black.withOpacity(0.1)),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => BellDialog(
                            status: status,
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.white.withOpacity(0),
                        height: MediaQuery.of(context).size.width * 0.1,
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Padding(
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.03,
                          ),
                          child: status != "calledService"
                              ? Icon(
                                  Icons.notifications_active,
                                  color: Colors.white,
                                  size:
                                      MediaQuery.of(context).size.width * 0.04,
                                )
                              : Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
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
                      child: Container(
                        color: Colors.white.withOpacity(0),
                        height: MediaQuery.of(context).size.width * 0.1,
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03),
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
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
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.068,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        letterSpacing: 3,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextButton(
                                  textSize:
                                      MediaQuery.of(context).size.width * 0.025,
                                  buttonHeight:
                                      MediaQuery.of(context).size.width * 0.055,
                                  buttonWidth:
                                      MediaQuery.of(context).size.width * 0.32,
                                  buttonText: "Getränke",
                                  buttonAction: () {
                                    Navigator.of(context)
                                        .pushNamed(CategoryScreenConnected.id,
                                            arguments: ScreenArguments(
                                              path: _firestore
                                                  .collection("menu")
                                                  .doc("beverages")
                                                  .collection("categories"),
                                              title: "Getränke",
                                            ));
                                  },
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.03),
                                CustomTextButton(
                                  textSize:
                                      MediaQuery.of(context).size.width * 0.025,
                                  buttonHeight:
                                      MediaQuery.of(context).size.width * 0.055,
                                  buttonWidth:
                                      MediaQuery.of(context).size.width * 0.32,
                                  buttonText: "Speisen",
                                  buttonAction: () {
                                    Navigator.of(context).pushNamed(
                                      CategoryScreenConnected.id,
                                      arguments: ScreenArguments(
                                        path: _firestore
                                            .collection("menu")
                                            .doc("food")
                                            .collection("categories"),
                                        title: "Speisekarte",
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.03),
                            CustomTextButton(
                              textSize:
                                  MediaQuery.of(context).size.width * 0.025,
                              buttonHeight:
                                  MediaQuery.of(context).size.width * 0.055,
                              buttonWidth:
                                  MediaQuery.of(context).size.width * 0.32,
                              buttonText: "Zahlen",
                              backgroundColor: ableToPay == true
                                  ? Colors.white
                                  : Colors.white.withOpacity(1),
                              textColor: ableToPay == true
                                  ? Colors.black87
                                  : Colors.black.withOpacity(0.5),
                              buttonAction: () {
                                if (ableToPay == true) {
                                  showDialog(
                                    context: context,
                                    builder: (_) =>
                                        PayDialog(tableNumber: tableNumber),
                                  );
                                }
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
          );
        },
      ),
    );
  }
}
