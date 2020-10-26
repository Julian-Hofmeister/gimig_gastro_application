import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/classes/item_class.dart';
import 'package:gimig_gastro_application/classes/shopping_cart.dart';
import 'package:gimig_gastro_application/components/cards/order_card.dart';
import 'package:gimig_gastro_application/components/elements/background_layout.dart';
import 'package:gimig_gastro_application/components/elements/navigationbar.dart';
import 'package:gimig_gastro_application/components/elements/text_button.dart';
import 'package:gimig_gastro_application/functions/firebase_functions.dart';
import 'package:gimig_gastro_application/functions/table_number_storage.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/objects/category_example.dart';
import 'package:gimig_gastro_application/screens/overview_screen.dart';

class CartScreen extends StatefulWidget {
  static const String id = 'cart_screen';
  final TableNumberStorage storage = TableNumberStorage();

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  // final _auth = FirebaseAuth.instance;
  // FirebaseUser loggedInUser;

  final _firestore = Firestore.instance;
  String timestamp;
  int tableNumber;

  @override
  void initState() {
    super.initState();
    // firebaseFunctions.getCurrentUser();
    widget.storage.readTableNumber().then((int value) {
      setState(() {
        tableNumber = value;
      });
    });
  }

  // void getCurrentUser() async {
  //   try {
  //     final user = await _auth.currentUser();
  //     if (user != null) {}
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void getTime() {
    timestamp = Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch)
        .toString();
  }

  void order() {
    // getCurrentUser();
    setState(() {
      getTime();

      for (Item item in shoppingCart.shoppingList) {
        _firestore.collection("items").add({
          "name": item.name,
          "amount": item.amount,
          "price": item.price,
          "sender": "venezia-gimig",
          "tableNumber": tableNumber,
          "timestamp": timestamp,
          "progress": false,
        });
      }
      for (Item item in shoppingCart.shoppingList) {
        shoppingCart.orderdList.insert(0, item);
      }
      shoppingCart.shoppingList.clear();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: <Widget>[
          Backgroundlayout(
            name: "Bestellung",
          ),
          GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: kScrollEffect,
            child: ListView(
              padding: EdgeInsets.only(top: 50, right: 100),
              children: <Widget>[
                ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: List.generate(
                      shoppingCart.shoppingList.length,
                      (index) => OrderCard(
                            item: shoppingCart.shoppingList[index],
                          )),
                ),
                if (shoppingCart.shoppingList.length > 0)
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 160, right: 160, top: 50, bottom: 80),
                  //   child: SizedBox(
                  //     height: 50,
                  //     child: FlatButton(
                  //       color: kAccentColor,
                  //       splashColor: Colors.white,
                  //       highlightColor: Colors.grey,
                  //       child: Text(
                  //         "Bestellung Abschließen",
                  //         style: kFoodCardDescriptionTextStyle.copyWith(
                  //             fontSize: 22,
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //       onPressed: () {
                  //         order();
                  //       },
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 160, right: 160, top: 50, bottom: 80),
                    child: TextButton(
                      buttonText: "Bestellung Abschließen",
                      buttonAction: order,
                      backgroundColor: kAccentColor,
                      textColor: Colors.white,
                    ),
                  ),
                if (shoppingCart.shoppingList.length == 0)
                  SizedBox(
                    height: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 400,
                          child: Text(
                            "Sie haben noch keine Getränke oder Speisen gewählt.",
                            style:
                                kFoodCardPriceTextStyle.copyWith(fontSize: 22),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 60),
                        TextButton(
                          buttonWidth: 400,
                          buttonText: "Getränke wählen",
                          backgroundColor: kAccentColor,
                          textColor: Colors.white,
                          buttonAction: () {
                            Navigator.of(context).pushNamed(OverviewScreen.id,
                                arguments: beverages);
                          },
                        ),
                        SizedBox(height: 30),
                        TextButton(
                          buttonWidth: 400,
                          buttonText: "Speisen wählen",
                          backgroundColor: kAccentColor,
                          textColor: Colors.white,
                          buttonAction: () {
                            Navigator.of(context).pushNamed(OverviewScreen.id,
                                arguments: courses);
                          },
                        ),
                      ],
                    ),
                  ),
                if (shoppingCart.orderdList.length > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 153.0, top: 50),
                    child: Text(
                      "Bereits bestellt:",
                      style: kFoodCardTitleTextStyle.copyWith(
                        fontSize: 22,
                        color: kAccentColor,
                      ),
                    ),
                  ),
                ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: List.generate(
                    shoppingCart.orderdList.length,
                    (index) => AbsorbPointer(
                      child: OrderCard(
                        item: shoppingCart.orderdList[index],
                        state: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          DrawerPreview(
            buttonActionNavigator: () => _scaffoldKey.currentState.openDrawer(),
          ),
        ],
      ),
    );
  }
}
