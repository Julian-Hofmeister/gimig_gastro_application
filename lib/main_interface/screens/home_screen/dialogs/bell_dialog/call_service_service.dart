import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gimig_gastro_application/settings/services/table_number_storage.dart';

class CallServiceService {
  final _firestore = FirebaseFirestore.instance
      .collection("restaurants")
      .doc("${FirebaseAuth.instance.currentUser.email}")
      .collection("tables");

  final TableNumberStorageService storage = TableNumberStorageService();

  Future<void> callService({context, tableNumber}) async {
    //CLOSE DIALOG
    // Navigator.of(context).pop();

    // showDialog(
    //   context: context,
    //   builder: (_) => BellSuccessDialog(),
    // );

    //GET TABLENUMBER
    await storage.readTableNumber().then((int value) {
      tableNumber = value;
    });

    //UPDATE STATUS
    await _firestore
        .doc("$tableNumber")
        .update({"serviceRequest": true, "status": "active"});
  }
}
