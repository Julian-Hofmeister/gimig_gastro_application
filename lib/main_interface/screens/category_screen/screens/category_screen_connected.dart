import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main_interface/screens/category_screen/class/category_class.dart';
import 'package:gimig_gastro_application/main_interface/components/background_layout/background_layout.dart';
import 'package:gimig_gastro_application/main_interface/components/navigation_bar/side_navigationbar.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/main_interface/screens/category_screen/components/category_card.dart';

class CategoryScreenConnected extends StatefulWidget {
  static const String id = 'category_screen_connected';

  CategoryScreenConnected({this.title, this.path});

  final String title;
  final CollectionReference path;

  @override
  _CategoryScreenConnectedState createState() =>
      _CategoryScreenConnectedState();
}

class _CategoryScreenConnectedState extends State<CategoryScreenConnected> {
  double widget1Opacity = 0.0;

  fadeIn() {
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        widget1Opacity = 1;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fadeIn();
    print(widget1Opacity);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: kBackgroundColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: widget.path.orderBy("image").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.orangeAccent,
              ),
            );
          }

          List<Widget> categoryList = [];
          List<Category> categories = [];
          final images = snapshot.data.docs;

          for (var document in images) {
            print(document.metadata.isFromCache
                ? "NOT FROM NETWORK"
                : "FROM NETWORK");

            final id = document.id;
            final name = document.data()['name'];
            final image = document.data()['image'];
            final hasSubcategory = document.data()['hasSubcategory'];

            Category category = Category(
              id: id,
              title: name,
              coverImage: image,
              hasSubcategory: hasSubcategory,
            );

            categories.insert(0, category);

            final categoryCard = CategoryCard(
              category: category,
              path: widget.path,
            );
            categoryList.insert(0, categoryCard);
          }
          return Stack(
            children: <Widget>[
              BackgroundLayout(
                name: widget.title,
              ),
              GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: kScrollEffect,
                child: AnimatedOpacity(
                  opacity: widget1Opacity,
                  duration: Duration(milliseconds: 300),
                  child: ListView(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.03,
                        left: MediaQuery.of(context).size.width * 0.12),
                    children: categoryList,
                  ),
                ),
              ),
              SideNavigationBar(),
            ],
          );
        },
      ),
    );
  }
}
