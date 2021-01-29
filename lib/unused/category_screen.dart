import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main_interface/screens/category_screen/class/category_class.dart';
import 'package:gimig_gastro_application/main_interface/components/background_layout/background_layout.dart';
import 'package:gimig_gastro_application/main_interface/components/navigation_bar/side_navigationbar.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/main_interface/screens/category_screen/components/category_card/category_card.dart';

// ignore: must_be_immutable
class CategoryScreen extends StatelessWidget {
  static const String id = 'overview_screen';

  CategoryScreen({this.category});
  Category category;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: kBackgroundColor,
      body: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          BackgroundLayout(
            name: category.title,
          ),
          ScrollConfiguration(
            behavior: new ScrollBehavior()
              ..buildViewportChrome(context, null, AxisDirection.down),
            child: ListView(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.03,
                  left: MediaQuery.of(context).size.width * 0.12),
              children: List.generate(
                category.items.length,
                (index) => CategoryCard(
                  category: category,
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
