import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/dialogs/bell_success_dialog.dart';
import 'package:gimig_gastro_application/functions/table_number_storage.dart';
import 'package:gimig_gastro_application/main/constants.dart';

class BellDialog extends StatefulWidget {
  final TableNumberStorage storage = TableNumberStorage();
  BellDialog({this.status});
  final String status;

  @override
  _BellDialogState createState() => _BellDialogState();
}

class _BellDialogState extends State<BellDialog> {
  int tableNumber;

  final _firestore = FirebaseFirestore.instance
      .collection("restaurants")
      .doc("${FirebaseAuth.instance.currentUser.email}")
      .collection("tables");

  Future<void> callService() async {
    //CLOSE DIALOG
    Navigator.of(context).pop();

    showDialog(
      context: context,
      builder: (_) => BellSuccessDialog(),
    );

    //GET TABLENUMBER
    await widget.storage.readTableNumber().then((int value) {
      setState(() {
        tableNumber = value;
      });
    });

    //UPDATE STATUS
    await _firestore.doc("$tableNumber").update({"status": "calledService"});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      content: Container(
        width: 500,
        height: 250,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (widget.status != "calledService")
              Text(
                "Bei Fragen oder Wünschen wenden sie sich gerne an unser Personal.\n\nSoll eine Bedienung benachrichtigt werden?",
                style: kFoodCardDescriptionTextStyle.copyWith(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            if (widget.status == "calledService")
              Text(
                "Sie haben bereits eine Bedienung gerufen.\n\nSoll erneut eine Nachricht gesendet werden?",
                style: kFoodCardDescriptionTextStyle.copyWith(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                  height: 50,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    color: kAccentColor,
                    splashColor: Colors.white,
                    highlightColor: Colors.grey,
                    child: Text("Benachrichtigen",
                        style: kFoodCardDescriptionTextStyle.copyWith(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      callService();
                    },
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: OutlineButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    borderSide: BorderSide(color: kAccentColor, width: 2),
                    color: Color(0xFFFF6633),
                    splashColor: Colors.white,
                    highlightColor: kAccentColor,
                    highlightedBorderColor: kAccentColor,
                    child: Text(
                      "Abbrechen",
                      style: kFoodCardDescriptionTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
