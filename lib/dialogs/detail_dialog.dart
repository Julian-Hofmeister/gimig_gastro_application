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
          Radius.circular(20),
        ),
      ),
      contentPadding: EdgeInsets.all(0),
      content: Container(
        width: 800,
        height: 450,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 250,
                  height: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(230),
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(20),
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
                        width: 400,
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
                        width: 400,
                        child: Text(
                          widget.item.description,
                          style: kFoodCardDescriptionTextStyle.copyWith(
                              fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          if (widget.cartAccess == true)
                            Row(
                              children: [
                                OrderButton(
                                  buttonIcon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  buttonWidth: 50,
                                  buttonHeight: 50,
                                  buttonAction: () {
                                    setState(() {
                                      if (shoppingCart.shoppingList
                                          .contains(widget.item)) {
                                        shoppingCart.shoppingList
                                            .remove(widget.item);
                                      }
                                      Navigator.pushReplacementNamed(
                                        context,
                                        CartScreen.id,
                                      );
                                    });
                                  },
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  height: 40,
                                  width: 1,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          OrderButton(
                            buttonIcon: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 20,
                            ),
                            buttonName: "-",
                            buttonWidth: 50,
                            buttonHeight: 50,
                            buttonAction: () {
                              setState(() {
                                if (widget.item.amount > 1) {
                                  widget.item.amount--;
                                }
                              });
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          OrderButton(
                            buttonIcon: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                            buttonName: "+",
                            buttonWidth: 50,
                            buttonHeight: 50,
                            buttonAction: () {
                              setState(() {
                                if (widget.item.amount < 30) {
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
                        buttonName:
                            shoppingCart.shoppingList.contains(widget.item)
                                ? "Bestätigen"
                                : "Hinzufügen",
                        buttonAction: () {
                          setState(
                            () {
                              if (widget.cartAccess == false) {
                                Navigator.pop(context);
                                showDialog(
                                    context: (context),
                                    builder: (_) => GoOnDialog());
                              } else {
                                Navigator.pushReplacementNamed(
                                  context,
                                  CartScreen.id,
                                );
                              }

                              // TODO ADD SAME ITEMS
                              var i = 0;
                              while (i < widget.item.amount) {
                                if (shoppingCart.shoppingList
                                    .contains(widget.item)) {
                                  shoppingCart.shoppingList.remove(widget.item);
                                }
                                shoppingCart.shoppingList
                                    .insert(0, widget.item);

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
