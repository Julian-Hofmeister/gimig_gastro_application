import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/functions/table_number_storage.dart';
import 'package:gimig_gastro_application/main/constants.dart';

class BellSuccessDialog extends StatelessWidget {
  final TableNumberStorage storage = TableNumberStorage();
  BellSuccessDialog({this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        content: Container(
          width: 400,
          height: 200,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Es wurde erfolgreich eine Bedienung gerufen",
                style: kFoodCardDescriptionTextStyle.copyWith(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
