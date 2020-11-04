import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main/constants.dart';

class Message1 extends StatefulWidget {
  @override
  _Message1State createState() => _Message1State();
}

class _Message1State extends State<Message1> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
              "Wir wünschen euch einen guten Appetit!",
              style: kFoodCardDescriptionTextStyle.copyWith(fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
