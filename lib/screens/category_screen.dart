import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/classes/category_class.dart';
import 'package:gimig_gastro_application/components/cards/category_card.dart';
import 'package:gimig_gastro_application/components/elements/background_layout.dart';
import 'package:gimig_gastro_application/components/elements/side_navigationbar.dart';
import 'package:gimig_gastro_application/main/constants.dart';

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
                  name: category.items[index].title,
                  image: category.items[index].coverImage,
                  buttonAction: () {
                    Navigator.of(context).pushNamed(
                      category.items[index].pushScreen,
                      arguments: category.items[index],
                    );
                  },
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
