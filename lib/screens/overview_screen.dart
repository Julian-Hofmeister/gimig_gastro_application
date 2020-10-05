import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/classes/category_class.dart';
import 'package:gimig_gastro_application/components/cards/category_card.dart';
import 'package:gimig_gastro_application/components/elements/background_layout.dart';
import 'package:gimig_gastro_application/components/elements/navigationbar.dart';
import 'package:gimig_gastro_application/main/constants.dart';

// ignore: must_be_immutable
class OverviewScreen extends StatefulWidget {
  static const String id = 'overview_screen';

  OverviewScreen({this.category});
  Category category;

  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: kBackgroundColor,
      body: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Backgroundlayout(
            name: widget.category.title,
          ),
          ScrollConfiguration(
            behavior: new ScrollBehavior()
              ..buildViewportChrome(context, null, AxisDirection.down),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (300 / 370),
              padding: EdgeInsets.only(top: 50, left: 90, right: 90),
              children: List.generate(
                widget.category.items.length,
                (index) => CategoryCard(
                  name: widget.category.items[index].title,
                  image: widget.category.items[index].coverImage,
                  buttonAction: () {
                    Navigator.of(context).pushNamed(
                      widget.category.items[index].pushScreen,
                      arguments: widget.category.items[index],
                    );
                  },
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
