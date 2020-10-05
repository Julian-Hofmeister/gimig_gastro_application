import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/classes/category_class.dart';
import 'package:gimig_gastro_application/components/cards/big_card.dart';
import 'package:gimig_gastro_application/components/elements/background_layout.dart';
import 'package:gimig_gastro_application/components/elements/navigationbar.dart';
import 'package:gimig_gastro_application/main/constants.dart';

class BigCardScreen extends StatefulWidget {
  static const String id = 'big_card_screen';
  BigCardScreen({this.category});
  final Category category;

  @override
  _BigCardScreenState createState() => _BigCardScreenState();
}

class _BigCardScreenState extends State<BigCardScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: <Widget>[
          Backgroundlayout(
            name: widget.category.title,
          ),
          GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: kScrollEffect,
            child: GridView.count(
              padding: EdgeInsets.only(top: 50, left: 60, right: 60),
              crossAxisCount: 2,
              childAspectRatio: (300 / 370),
              children: List.generate(
                widget.category.items.length,
                (index) => BigCard(
                  currentMeal: widget.category.items[index],
                ),
              ),
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
