import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/classes/category_class.dart';
import 'package:gimig_gastro_application/classes/item_class.dart';
import 'package:gimig_gastro_application/components/cards/small_card_connected.dart';
import 'package:gimig_gastro_application/components/elements/background_layout.dart';
import 'package:gimig_gastro_application/components/elements/side_navigationbar.dart';
import 'package:gimig_gastro_application/main/constants.dart';

class DailyMenuBetaScreen extends StatefulWidget {
  static const String id = 'daily_menu_screen';
  DailyMenuBetaScreen({this.category});
  final Category category;

  @override
  _DailyMenuBetaScreenState createState() => _DailyMenuBetaScreenState();
}

class _DailyMenuBetaScreenState extends State<DailyMenuBetaScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String currentUserEmail = FirebaseAuth.instance.currentUser.email;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: kBackgroundColor,
      body: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection(currentUserEmail)
              .doc("menu")
              .collection("daily_menu")
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
                  name: widget.category.title,
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
