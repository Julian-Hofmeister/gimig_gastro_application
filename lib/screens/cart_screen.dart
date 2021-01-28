import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/classes/item_class.dart';
import 'package:gimig_gastro_application/classes/shopping_cart.dart';
import 'package:gimig_gastro_application/components/cards/order_card.dart';
import 'package:gimig_gastro_application/components/elements/background_layout.dart';
import 'package:gimig_gastro_application/components/elements/side_navigationbar.dart';
import 'package:gimig_gastro_application/components/elements/text_button.dart';
import 'package:gimig_gastro_application/dialogs/error_dialog.dart';
import 'package:gimig_gastro_application/services/table_number_storage.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/objects/category_example.dart';
import 'package:gimig_gastro_application/unused/category_screen.dart';

class CartScreen extends StatefulWidget {
  static const String id = 'cart_screen';
  final TableNumberStorageService storage = TableNumberStorageService();

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _firestore = FirebaseFirestore.instance;
  String currentUserEmail = FirebaseAuth.instance.currentUser.email;
  String timestamp;
  int tableNumber;

  @override
  void initState() {
    super.initState();
    widget.storage.readTableNumber().then((int value) {
      setState(() {
        tableNumber = value;
      });
    });
  }

  void getTime() {
    timestamp = Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch)
        .toString();
  }

  // SEND ORDER
  void order() async {
    if (await DataConnectionChecker().hasConnection != true) {
      await showDialog(
        context: context,
        builder: (_) => ErrorDialog(),
      );
    } else {
      // GET CURRENT TIME
      getTime();

      // ADD EACH ITEM TO ORDERS
      for (Item item in shoppingCart.shoppingList) {
        _firestore
            .collection("restaurants")
            .doc("$currentUserEmail")
            .collection("tables")
            .doc("$tableNumber")
            .collection("orders")
            .add({
          "name": item.name,
          "amount": item.amount,
          "price": item.price,
          "tableNumber": tableNumber,
          "timestamp": timestamp,
          "isFood": item.isFood,
          "inProgress": false,
          "isPaid": false,
        });
      }

      // SEND ORDER REQUEST
      _firestore
          .collection("restaurants")
          .doc("$currentUserEmail")
          .collection("tables")
          .doc("$tableNumber")
          .set({
        "tableNumber": tableNumber,
        "status": "orderRequest",
      });

      // CLEAR SHOPPING CART
      setState(() {
        for (Item item in shoppingCart.shoppingList) {
          shoppingCart.orderedList.insert(0, item);
        }
        shoppingCart.shoppingList.clear();
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: <Widget>[
          BackgroundLayout(
            name: "Bestellung",
          ),
          GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: kScrollEffect,
            child: ListView(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05,
                  left: MediaQuery.of(context).size.width * 0.12),
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
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.05,
                        bottom: MediaQuery.of(context).size.width * 0.04,
                        right: MediaQuery.of(context).size.width * 0.2),
                    child: CustomTextButton(
                      buttonText: "Bestellung Abschließen",
                      buttonAction: order,
                      backgroundColor: kAccentColor,
                      textColor: Colors.white,
                    ),
                  ),
                if (shoppingCart.shoppingList.length == 0)
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.05,
                        bottom: MediaQuery.of(context).size.width * 0.04,
                        right: MediaQuery.of(context).size.width * 0.2),
                    height: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "Sie haben noch keine Getränke oder Speisen gewählt.",
                            style: kFoodCardPriceTextStyle.copyWith(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.0245,
                                color: kDetailColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.06),
                        CustomTextButton(
                          buttonWidth: MediaQuery.of(context).size.width * 0.4,
                          buttonText: "Getränke wählen",
                          backgroundColor: kAccentColor,
                          textColor: Colors.white,
                          buttonAction: () {
                            Navigator.of(context).pushNamed(CategoryScreen.id,
                                arguments: beverages);
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.03),
                        CustomTextButton(
                          buttonWidth: MediaQuery.of(context).size.width * 0.4,
                          buttonText: "Speisen wählen",
                          backgroundColor: kAccentColor,
                          textColor: Colors.white,
                          buttonAction: () {
                            Navigator.of(context).pushNamed(CategoryScreen.id,
                                arguments: courses);
                          },
                        ),
                      ],
                    ),
                  ),
                if (shoppingCart.orderedList.length > 0)
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.05,
                        left: MediaQuery.of(context).size.width * 0.12),
                    child: Text(
                      "Bereits bestellt:",
                      style: kFoodCardTitleTextStyle.copyWith(
                        fontSize: (MediaQuery.of(context).size.width *
                                MediaQuery.of(context).size.height) *
                            0.000036,
                        color: kAccentColor,
                      ),
                    ),
                  ),
                ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: List.generate(
                    shoppingCart.orderedList.length,
                    (index) => AbsorbPointer(
                      child: OrderCard(
                        item: shoppingCart.orderedList[index],
                        state: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SideNavigationBar(),
        ],
      ),
    );
  }
}
