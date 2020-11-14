import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gimig_gastro_application/main/constants.dart';

// ignore: must_be_immutable
class PayDialog extends StatefulWidget {
  static const String id = 'pay_dialog';
  PayDialog({this.tableNumber});

  final int tableNumber;

  @override
  _PayDialogState createState() => _PayDialogState();
}

class _PayDialogState extends State<PayDialog> {
  bool isTogether;

  bool isCache;

  Future sendPayRequest({tableNumber}) async {
    await Firestore.instance
        .collection('restaurants')
        .document('venezia')
        .collection('tables')
        .document("$tableNumber")
        .updateData({
      "status": "payRequest",
      "isTogether": isTogether,
      "isCache": isCache
    });
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(1),
      )),
      contentPadding: EdgeInsets.all(0),
      content: Container(
        width: 700,
        height: 450,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 300,
                        alignment: Alignment.centerLeft,
                        child: Title(
                          child: Text(
                            "Bezahlen",
                            style: kFoodCardTitleTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 500,
                        child: Text(
                          "Für das Bezahlen wird eine Bedienung gerufen. Bitte geben sie an wie sie bezahlen möchten.",
                          style: kFoodCardDescriptionTextStyle.copyWith(
                              fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isTogether = true;
                              });
                            },
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isTogether == true
                                    ? Colors.blueGrey
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                "Zusammen",
                                style: kFoodCardDescriptionTextStyle.copyWith(
                                  color: isTogether == true
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isTogether = false;
                              });
                            },
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isTogether == false
                                    ? Colors.blueGrey
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                "Getrennt",
                                style: kFoodCardDescriptionTextStyle.copyWith(
                                  color: isTogether == false
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isCache = true;
                              });
                            },
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isCache == true
                                    ? Colors.blueGrey
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Bar",
                                  style: kFoodCardDescriptionTextStyle.copyWith(
                                    color: isCache == true
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isCache = false;
                              });
                            },
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isCache == false
                                    ? Colors.blueGrey
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Mit Karte",
                                  style: kFoodCardDescriptionTextStyle.copyWith(
                                    color: isCache == false
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            sendPayRequest(tableNumber: widget.tableNumber);
                          },
                          child: Container(
                            width: 430,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Bedieung rufen",
                                style: kFoodCardDescriptionTextStyle.copyWith(
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
