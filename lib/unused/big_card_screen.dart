import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/classes/category_class.dart';
import 'package:gimig_gastro_application/components/cards/big_card.dart';
import 'package:gimig_gastro_application/components/elements/background_layout.dart';
import 'package:gimig_gastro_application/components/elements/side_navigationbar.dart';
import 'package:gimig_gastro_application/main/constants.dart';

class BigCardScreen extends StatelessWidget {
  static const String id = 'big_card_screen';
  BigCardScreen({this.category});
  final Category category;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: kBackgroundColor,
      body: Stack(
        // TODO ADD NAVIGATION ARROWS
        children: <Widget>[
          BackgroundLayout(
            name: category.title,
          ),
          GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: kScrollEffect,
            child: GridView.count(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.03,
                  left: MediaQuery.of(context).size.width * 0.12),
              crossAxisCount: 2,
              childAspectRatio: (300 / 370),
              children: List.generate(
                category.items.length,
                (index) => BigCard(
                  currentMeal: category.items[index],
                ),
              ),
            ),
          ),
          SideNavigationBar(),
        ],
      ),
    );
  }
}
