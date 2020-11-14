import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/classes/item_class.dart';
import 'package:gimig_gastro_application/dialogs/detail_dialog.dart';
import 'package:gimig_gastro_application/main/constants.dart';

// ignore: must_be_immutable
class OrderCard extends StatelessWidget {
  OrderCard({
    this.buttonAction,
    this.item,
    this.state = false,
  });
  final Function buttonAction;
  Item item;
  bool state;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => DetailDialog(
            item: item,
            cartAccess: true,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150,
              height: 180,
              foregroundDecoration: BoxDecoration(
                color: state == true
                    ? Colors.white.withOpacity(0.4)
                    : Colors.white.withOpacity(0),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(1),
                ),
                image: DecorationImage(
                  image: AssetImage(item.image),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 180,
              width: 450,
              foregroundDecoration: BoxDecoration(
                color: state == true
                    ? Colors.white.withOpacity(0.4)
                    : Colors.white.withOpacity(0),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(1),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 400,
                          child: Text(
                            item.name,
                            style:
                                kFoodCardTitleTextStyle.copyWith(fontSize: 22),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          item.price,
                          style: kFoodCardPriceTextStyle,
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        // Row(
                        //   children: <Widget>[
                        //     SizedBox(
                        //       width: 200,
                        //     ),
                        //     Text(
                        //       "Menge:  ${widget.currentMeal.amount}",
                        //       style: kFoodCardPriceTextStyle,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 140,
                    right: 100,
                    child: Text(
                      "Menge:  ${item.amount}",
                      style: kFoodCardPriceTextStyle,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => DetailDialog(
                          item: item,
                          cartAccess: true,
                        ),
                      );
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: kAccentColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(1),
                          ),
                        ),
                        width: 70,
                        height: 70,
                        child: Icon(
                          Icons.edit,
                          size: 30,
                          color: kBackgroundColor,
                        ),
                      ),
                    ),
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
