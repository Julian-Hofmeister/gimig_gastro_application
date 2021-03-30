import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/main_interface/dialogs/error_dialog.dart';
import 'package:gimig_gastro_application/main_interface/screens/cart_screen/services/send_order_service.dart';
import 'package:gimig_gastro_application/main_interface/screens/home_screen/screens/welcome_screen.dart';

class ConfirmDialog extends StatefulWidget {
  ConfirmDialog({this.tableNumber});

  final tableNumber;

  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  DocumentReference _firestore = FirebaseFirestore.instance
      .collection("restaurants")
      .doc("${FirebaseAuth.instance.currentUser.email}");

  SendOrderService sendOrderService = SendOrderService();

  void sendOrder({context, tableNumber}) async {
    if (await DataConnectionChecker().hasConnection != true) {
      await showDialog(
        context: context,
        builder: (_) => ErrorDialog(),
      );
    } else {
      sendOrderService.getTime();

      sendOrderService.orderItems(tableNumber, _firestore);

      sendOrderService.sendOrderRequest(tableNumber, _firestore);

      setState(() {
        sendOrderService.clearShoppingCart();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      content: Container(
        width: 500,
        height: 250,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Möchten sie die Bestellung \nabschließen?",
              style: kFoodCardDescriptionTextStyle.copyWith(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                  height: 50,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    color: kAccentColor,
                    splashColor: Colors.white,
                    highlightColor: Colors.grey,
                    child: Text("Bestellen",
                        style: kFoodCardDescriptionTextStyle.copyWith(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.pushNamed(context, WelcomeScreen.id);

                      sendOrder(
                          context: context, tableNumber: widget.tableNumber);
                    },
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: OutlineButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    borderSide: BorderSide(color: kAccentColor, width: 2),
                    color: Color(0xFFFF6633),
                    splashColor: Colors.white,
                    highlightColor: kAccentColor,
                    highlightedBorderColor: kAccentColor,
                    child: Text(
                      "Abrechen",
                      style: kFoodCardDescriptionTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
