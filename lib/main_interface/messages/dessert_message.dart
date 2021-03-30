import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main_interface/messages/dessert_message/components/item_page.dart';
import 'package:gimig_gastro_application/main_interface/screens/item_screen/class/item_class.dart';

class DessertMessage extends StatefulWidget {
  static const String id = 'detail_dialog';

  @override
  _DessertMessageState createState() => _DessertMessageState();
}

DocumentReference _firestore = FirebaseFirestore.instance
    .collection("restaurants")
    .doc("${FirebaseAuth.instance.currentUser.email}");

final _controller = new PageController();
const _kDuration = const Duration(milliseconds: 300);
const _kCurve = Curves.ease;

@override
class _DessertMessageState extends State<DessertMessage> {
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection("menu")
          .doc("food")
          .collection("categories")
          .doc("Dessert")
          .collection("items")
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

          print("$id + $name + $image + $description + $price");

          Item item = Item(
            id: id,
            name: name,
            image: image,
            description: description,
            price: price,
          );

          items.insert(0, item);

          final itemCard = ItemPage(
            item: item,
          );
          itemList.insert(0, itemCard);
        }
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _controller,
                  itemBuilder: (BuildContext context, int index) {
                    return itemList[index % itemList.length];
                  },
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 100,
                    height: 80,
                    color: Colors.white.withOpacity(0),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      _controller.previousPage(
                          duration: _kDuration, curve: _kCurve);
                    },
                    child: Container(
                      width: 120,
                      height: 100,
                      color: Colors.white.withOpacity(0),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      _controller.nextPage(
                          duration: _kDuration, curve: _kCurve);
                    },
                    child: Container(
                      width: 120,
                      height: 100,
                      color: Colors.white.withOpacity(0),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
