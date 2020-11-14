// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:gimig_gastro_application/classes/item_class.dart';
// import 'package:gimig_gastro_application/classes/shopping_cart.dart';
// import 'package:gimig_gastro_application/functions/table_number_storage.dart';
//
// class Order {
//   Order({this.tableNumber});
//   int tableNumber;
//   final _firestore = Firestore.instance;
//   final TableNumberStorage storage = TableNumberStorage();
//   String timestamp;
//   // SEND ORDER
//
//   int getTablenumber() {
//     tableNumber = storage.readTableNumber().then((int value) {
//       return value;
//     });
//     return 0;
//   }
//
//   void getTime() {
//     timestamp = Timestamp.fromMillisecondsSinceEpoch(
//             DateTime.now().millisecondsSinceEpoch)
//         .toString();
//   }
//
//   void order() {
//     // GET CURRENT TIME
//     getTime();
//
//     // ADD EACH ITEM TO ORDERS
//     for (Item item in shoppingCart.shoppingList) {
//       _firestore
//           .collection("restaurants")
//           .document("venezia")
//           .collection("tables")
//           .document("$tableNumber")
//           .collection("orders")
//           .add({
//         "name": item.name,
//         "amount": item.amount,
//         "price": item.price,
//         "tableNumber": tableNumber,
//         "timestamp": timestamp,
//         "isFood": item.isFood,
//         "inProgress": false,
//         "isPaid": false,
//       });
//     }
//
//     // SEND ORDER REQUEST
//     _firestore
//         .collection("restaurants")
//         .document("venezia")
//         .collection("tables")
//         .document("$tableNumber")
//         .setData({
//       "tableNumber": tableNumber,
//       "status": "orderRequest",
//     });
//
//     // CLEAR SHOPPING CART
//       for (Item item in shoppingCart.shoppingList) {
//         shoppingCart.orderdList.insert(0, item);
//       }
//       shoppingCart.shoppingList.clear();
//   }
// }
