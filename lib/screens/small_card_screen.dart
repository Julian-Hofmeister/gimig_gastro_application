import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/classes/category_class.dart';
import 'package:gimig_gastro_application/components/cards/small_card.dart';
import 'package:gimig_gastro_application/components/elements/background_layout.dart';
import 'package:gimig_gastro_application/components/elements/navigationbar.dart';
import 'package:gimig_gastro_application/main/constants.dart';

class SmallCardScreen extends StatefulWidget {
  static const String id = 'small_card_screen';
  SmallCardScreen({this.category});
  final Category category;

  @override
  _SmallCardScreenState createState() => _SmallCardScreenState();
}

class _SmallCardScreenState extends State<SmallCardScreen> {
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
            child: ListView(
              padding: EdgeInsets.only(top: 50, right: 100),
              children: List.generate(
                widget.category.items.length,
                (index) => SmallCard(
                  item: widget.category.items[index],
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
