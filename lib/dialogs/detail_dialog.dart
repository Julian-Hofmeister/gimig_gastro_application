import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/classes/item_class.dart';
import 'package:gimig_gastro_application/classes/shopping_cart.dart';
import 'package:gimig_gastro_application/components/elements/order_button.dart';
import 'package:gimig_gastro_application/dialogs/go_on_dialog.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/screens/cart_screen.dart';

// ignore: must_be_immutable
class DetailDialog extends StatefulWidget {
  static const String id = 'detail_dialog';
  DetailDialog({this.item, this.cartAccess = false});
  final bool cartAccess;
  final Item item;

  @override
  _DetailDialogState createState() => _DetailDialogState();
}

class _DetailDialogState extends State<DetailDialog> {
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(1),
      )),
      contentPadding: EdgeInsets.all(0),
      content: Container(
        width: 700,
        height: 450,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 150,
              right: 00,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 270,
                  height: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(400),
                      topLeft: Radius.circular(200),
                      topRight: Radius.circular(6),
                    ),
                    image: DecorationImage(
                        image: AssetImage(widget.item.image),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: 300,
                        alignment: Alignment.centerLeft,
                        child: Title(
                          child: Text(
                            widget.item.name,
                            style: kFoodCardTitleTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 320,
                        child: Text(
                          widget.item.description,
                          style: kFoodCardDescriptionTextStyle.copyWith(
                              fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          OrderButton(
                            buttonName: "-",
                            buttonWidth: 50,
                            buttonHeight: 50,
                            buttonAction: () {
                              setState(() {
                                if (widget.item.amount > 0) {
                                  widget.item.amount--;
                                }
                              });
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          OrderButton(
                            buttonName: "+",
                            buttonWidth: 50,
                            buttonHeight: 50,
                            buttonAction: () {
                              setState(() {
                                if (widget.item.amount < 20) {
                                  widget.item.amount++;
                                }
                              });
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Anzahl: ${widget.item.amount}",
                            style:
                                kFoodCardTitleTextStyle.copyWith(fontSize: 24),
                          ),
                        ],
                      ),
                      OrderButton(
                        buttonHeight: 50,
                        buttonName: widget.cartAccess == false
                            ? "Hinzufügen"
                            : "Bestätigen",
                        buttonAction: () {
                          setState(
                            () {
                              Navigator.pop(context);

                              if (widget.cartAccess == false) {
                                showDialog(
                                    context: (context),
                                    builder: (_) => GoOnDialog());
                              } else {
                                Navigator.pushReplacementNamed(
                                  context,
                                  CartScreen.id,
                                );
                              }

                              var i = 0;
                              while (i < widget.item.amount) {
                                if (shoppingCart.shoppingList
                                    .contains(widget.item)) {
                                } else {
                                  shoppingCart.shoppingList.add(widget.item);
                                }
                                print(shoppingCart.shoppingList);
                                i++;
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
