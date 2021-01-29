import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main_interface/screens/item_screen/class/item_class.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/main_interface/dialogs/detail_dialog.dart';

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
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            width: 700,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                    Radius.circular(20),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: item.imageFile,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 180,
                width: 540,
                foregroundDecoration: BoxDecoration(
                  color: state == true
                      ? Colors.white.withOpacity(0.4)
                      : Colors.white.withOpacity(0),
                ),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 450,
                            child: Text(
                              item.name,
                              style: kFoodCardTitleTextStyle.copyWith(
                                  fontSize: 22),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            item.price,
                            style: kFoodCardPriceTextStyle,
                          ),
                          SizedBox(
                            height: 35,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 25,
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
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(20),
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
        ],
      ),
    );
  }
}
