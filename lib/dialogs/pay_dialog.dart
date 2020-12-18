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
    await FirebaseFirestore.instance
        .collection('restaurants')
        .doc('venezia')
        .collection('tables')
        .doc("$tableNumber")
        .update({
      "status": "payRequest",
      "isTogether": isTogether,
      "isCache": isCache
    });
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(MediaQuery.of(context).size.width * 0.02),
      )),
      contentPadding: EdgeInsets.all(0),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.width * 0.45,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 300,
                        alignment: Alignment.center,
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
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.05,
                        child: Text(
                          "Für das Bezahlen wird eine Bedienung gerufen. Bitte geben sie an wie sie bezahlen möchten.",
                          style: kFoodCardDescriptionTextStyle.copyWith(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.02),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.04),
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
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.width * 0.05,
                              decoration: BoxDecoration(
                                color: isTogether == true
                                    ? Colors.blueGrey
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      MediaQuery.of(context).size.width * 0.05),
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
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isTogether = false;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.width * 0.05,
                              decoration: BoxDecoration(
                                color: isTogether == false
                                    ? Colors.blueGrey
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      MediaQuery.of(context).size.width * 0.05),
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
                        height: MediaQuery.of(context).size.width * 0.03,
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
                              width: MediaQuery.of(context).size.width * 0.02,
                              height: MediaQuery.of(context).size.width * 0.05,
                              decoration: BoxDecoration(
                                color: isCache == true
                                    ? Colors.blueGrey
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      MediaQuery.of(context).size.width * 0.05),
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
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isCache = false;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.width * 0.05,
                              decoration: BoxDecoration(
                                color: isCache == false
                                    ? Colors.blueGrey
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      MediaQuery.of(context).size.width * 0.05),
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
                        height: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            sendPayRequest(tableNumber: widget.tableNumber);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.43,
                            height: MediaQuery.of(context).size.width * 0.05,
                            decoration: BoxDecoration(
                              color: kAccentColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                    MediaQuery.of(context).size.width * 0.05),
                              ),
                            ),
                            child: Center(
                              child: Text("Bedieung rufen",
                                  style: kFoodCardDescriptionTextStyle.copyWith(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.022,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
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
