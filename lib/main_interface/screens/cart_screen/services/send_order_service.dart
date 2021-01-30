import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gimig_gastro_application/main_interface/screens/cart_screen/class/shopping_cart.dart';
import 'package:gimig_gastro_application/main_interface/screens/item_screen/class/item_class.dart';

class SendOrderService {
  String getTime() {
    return Timestamp.fromMillisecondsSinceEpoch(
      DateTime.now().millisecondsSinceEpoch,
    ).toString();
  }

  void orderItems(tableNumber, _firestore) {
    for (Item item in shoppingCart.shoppingList) {
      _firestore
          .collection("tables")
          .doc("$tableNumber")
          .collection("orders")
          .add({
        "name": item.name,
        "amount": item.amount,
        "price": item.price,
        "tableNumber": tableNumber,
        "timestamp": getTime(),
        "isFood": item.isFood,
        "inProgress": false,
        "isPaid": false,
      });
    }
  }

  void sendOrderRequest(tableNumber, _firestore) {
    _firestore.collection("tables").doc("$tableNumber").update({
      "tableNumber": tableNumber,
      "status": "active",
      "orderRequest": true,
      "orderTime": DateTime.now(),
    });
  }

  void clearShoppingCart() {
    for (Item item in shoppingCart.shoppingList) {
      shoppingCart.orderedList.insert(0, item);
    }
    shoppingCart.shoppingList.clear();
  }
}
