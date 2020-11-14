import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/classes/category_class.dart';
import 'package:gimig_gastro_application/components/cards/category_card.dart';
import 'package:gimig_gastro_application/components/elements/background_layout.dart';
import 'package:gimig_gastro_application/components/elements/side_navigationbar.dart';
import 'package:gimig_gastro_application/main/constants.dart';

// ignore: must_be_immutable
class OverviewScreen extends StatelessWidget {
  static const String id = 'overview_screen';

  OverviewScreen({this.category});
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
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (300 / 370),
              padding: EdgeInsets.only(top: 50, left: 90, right: 90),
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
