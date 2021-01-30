import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SendPayRequestService {
  DocumentReference _firestore = FirebaseFirestore.instance
      .collection("restaurants")
      .doc("${FirebaseAuth.instance.currentUser.email}");

  Future sendPayRequest({tableNumber, isCache, isTogether}) async {
    await _firestore.collection('tables').doc("$tableNumber").update(
      {
        "status": "active",
        "payRequest": true,
        "isTogether": isTogether,
        "isCache": isCache,
      },
    );
  }
}
