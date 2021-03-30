import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main_interface/screens/cart_screen/screens/cart_screen.dart';
import 'dart:io';
import 'package:gimig_gastro_application/settings/services/table_number_storage.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:numberpicker/numberpicker.dart';

class TableNumberDialog extends StatefulWidget {
  final TableNumberStorageService storage = TableNumberStorageService();

  @override
  _TableNumberDialogState createState() => _TableNumberDialogState();
}

class _TableNumberDialogState extends State<TableNumberDialog> {
  int tableNumber;

  @override
  void initState() {
    super.initState();
    widget.storage.readTableNumber().then((int value) {
      setState(() {
        if (value != null) {
          tableNumber = value;
        } else {
          tableNumber = 1;
        }
      });
    });
  }

  Future<File> _setTableNumber() {
    return widget.storage.writeTableNumber(tableNumber);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      content: Container(
        width: 600,
        height: 300,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tischnummer",
                  textAlign: TextAlign.center,
                  style: kFoodCardDescriptionTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(
                  width: 50,
                ),
                Theme(
                  data: theme.copyWith(
                      accentColor: kAccentColor, // highlighted color
                      textTheme: theme.textTheme.copyWith(
                        headline5: theme.textTheme.headline5
                            .copyWith(fontSize: 25), //other highlighted style
                        bodyText2: theme.textTheme.headline5
                            .copyWith(fontSize: 18), //not highlighted styles
                      )),
                  child: NumberPicker.integer(
                    initialValue: tableNumber,
                    minValue: 1,
                    maxValue: 200,
                    onChanged: (newValue) =>
                        setState(() => tableNumber = newValue),
                    decoration: BoxDecoration(
                      border: new Border(
                        top: new BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.black12,
                        ),
                        bottom: new BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
                    child: Text("Speichern",
                        style: kFoodCardDescriptionTextStyle.copyWith(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      _setTableNumber();
                      print(tableNumber);
                      Navigator.pop(context);
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
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
