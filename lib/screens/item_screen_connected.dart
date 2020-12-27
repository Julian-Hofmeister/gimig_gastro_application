import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/classes/item_class.dart';
import 'package:gimig_gastro_application/components/cards/small_card_connected.dart';
import 'package:gimig_gastro_application/components/elements/background_layout.dart';
import 'package:gimig_gastro_application/components/elements/side_navigationbar.dart';
import 'package:gimig_gastro_application/main/constants.dart';

class ItemScreenConnected extends StatefulWidget {
  static const String id = 'item_screen_connected';

  ItemScreenConnected({this.title, this.path});

  final String title;
  final CollectionReference path;

  @override
  _ItemScreenConnectedState createState() => _ItemScreenConnectedState();
}

class _ItemScreenConnectedState extends State<ItemScreenConnected> {
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
                price: price,
              );

              items.insert(0, item);

              final itemCard = SmallCardConnected(
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
                  child: ListView(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.03,
                        left: MediaQuery.of(context).size.width * 0.12),
                    children: itemList,
                  ),
                ),
                SideNavigationBar(),
              ],
            );
          }),
    );
  }
}
