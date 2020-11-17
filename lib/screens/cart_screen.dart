import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/classes/item_class.dart';
import 'package:gimig_gastro_application/classes/shopping_cart.dart';
import 'package:gimig_gastro_application/components/cards/order_card.dart';
import 'package:gimig_gastro_application/components/elements/background_layout.dart';
import 'package:gimig_gastro_application/components/elements/side_navigationbar.dart';
import 'package:gimig_gastro_application/components/elements/text_button.dart';
import 'package:gimig_gastro_application/functions/table_number_storage.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/objects/category_example.dart';
import 'package:gimig_gastro_application/screens/category_screen.dart';

class CartScreen extends StatefulWidget {
  static const String id = 'cart_screen';
  final TableNumberStorage storage = TableNumberStorage();

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _firestore = Firestore.instance;
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

  // TODO SEND SAME ITEMS TOGETHER
  // SEND ORDER
  void order() {
    // GET CURRENT TIME
    getTime();

    // ADD EACH ITEM TO ORDERS
    for (Item item in shoppingCart.shoppingList) {
      _firestore
          .collection("restaurants")
          .document("venezia")
          .collection("tables")
          .document("$tableNumber")
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
        .document("venezia")
        .collection("tables")
        .document("$tableNumber")
        .setData({
      "tableNumber": tableNumber,
      "status": "orderRequest",
    });

    // CLEAR SHOPPING CART
    setState(() {
      for (Item item in shoppingCart.shoppingList) {
        shoppingCart.orderdList.insert(0, item);
      }
      shoppingCart.shoppingList.clear();
    });
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
              padding: EdgeInsets.only(top: 50, left: 125),
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
                    padding:
                        const EdgeInsets.only(top: 50, bottom: 40, right: 200),
                    child: CustomTextButton(
                      buttonText: "Bestellung Abschließen",
                      buttonAction: order,
                      backgroundColor: kAccentColor,
                      textColor: Colors.white,
                    ),
                  ),
                if (shoppingCart.shoppingList.length == 0)
                  Container(
                    padding: EdgeInsets.only(top: 50, bottom: 40, right: 200),
                    height: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 400,
                          child: Text(
                            "Sie haben noch keine Getränke oder Speisen gewählt.",
                            style: kFoodCardPriceTextStyle.copyWith(
                                fontSize: 22, color: kDetailColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 60),
                        CustomTextButton(
                          buttonWidth: 400,
                          buttonText: "Getränke wählen",
                          backgroundColor: kAccentColor,
                          textColor: Colors.white,
                          buttonAction: () {
                            Navigator.of(context).pushNamed(CategoryScreen.id,
                                arguments: beverages);
                          },
                        ),
                        SizedBox(height: 30),
                        CustomTextButton(
                          buttonWidth: 400,
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
                if (shoppingCart.orderdList.length > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 20),
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
          SideNavigationBar(),
        ],
      ),
    );
  }
}
