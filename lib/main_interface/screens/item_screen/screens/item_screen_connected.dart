import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main_interface/screens/item_screen/class/item_class.dart';
import 'package:gimig_gastro_application/main_interface/components/background_layout/background_layout.dart';
import 'package:gimig_gastro_application/main_interface/components/navigation_bar/side_navigationbar.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/main_interface/screens/item_screen/components/item_card/item_card.dart';

class ItemScreenConnected extends StatefulWidget {
  static const String id = 'item_screen_connected';

  ItemScreenConnected({this.title, this.path});

  final String title;
  final CollectionReference path;

  @override
  _ItemScreenConnectedState createState() => _ItemScreenConnectedState();
}

class _ItemScreenConnectedState extends State<ItemScreenConnected> {
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
          stream: widget.path
              .doc(widget.title)
              .collection("items")
              .orderBy("image")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.orangeAccent,
                ),
              );
            }

            List<Widget> itemList = [];
            List<Item> items = [];
            final images = snapshot.data.docs;

            for (var document in images) {
              print(document.metadata.isFromCache
                  ? "NOT FROM NETWORK"
                  : "FROM NETWORK");

              final id = document.id;
              final name = document.data()['name'];
              final image = document.data()['image'];
              final description = document.data()['description'];
              final price = document.data()['price'];

              Item item = Item(
                id: id,
                name: name,
                image: image,
                description: description,
                price: price.toString(),
              );

              items.insert(0, item);

              final itemCard = ItemCard(
                item: item,
              );
              itemList.insert(0, itemCard);
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
                    duration: Duration(milliseconds: 100),
                    child: ListView(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.03,
                          left: MediaQuery.of(context).size.width * 0.12),
                      children: itemList,
                    ),
                  ),
                ),
                SideNavigationBar(),
              ],
            );
          }),
    );
  }
}
