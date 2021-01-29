import 'package:flutter/material.dart';
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
        tableNumber = value;
      });
    });
    startNumber();
  }

  Future<File> _setTableNumber() {
    return widget.storage.writeTableNumber(tableNumber);
  }

  startNumber() {
    if (tableNumber == null) {
      tableNumber = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.63,
        height: MediaQuery.of(context).size.width * 0.35,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Tischnummer",
                    textAlign: TextAlign.center,
                    style: kFoodCardDescriptionTextStyle.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Theme(
                    data: theme.copyWith(
                        accentColor: kAccentColor, // highlted color
                        textTheme: theme.textTheme.copyWith(
                          headline5: theme.textTheme.headline5.copyWith(
                              fontSize: MediaQuery.of(context).size.width *
                                  0.03), //other highlighted style
                          bodyText2: theme.textTheme.headline5.copyWith(
                              fontSize: MediaQuery.of(context).size.width *
                                  0.025), //not highlighted styles
                        )),
                    child: NumberPicker.integer(
                      initialValue: tableNumber,
                      minValue: 0,
                      maxValue: 200,
                      onChanged: (newValue) =>
                          setState(() => tableNumber = newValue),
                      decoration: BoxDecoration(
                        border: new Border(
                          top: new BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black26,
                          ),
                          bottom: new BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            OutlineButton(
              onPressed: () {
                _setTableNumber();
                print(tableNumber);
                Navigator.pop(context);
              },
              splashColor: Colors.deepOrangeAccent,
              highlightColor: Colors.white,
              highlightedBorderColor: kAccentColor,
              borderSide: BorderSide(color: kAccentColor, width: 2),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.06,
                width: MediaQuery.of(context).size.width * 0.25,
                child: Center(
                  child: Text(
                    "Auswählen",
                    style: TextStyle(
                        color: kFontColor1,
                        fontSize: MediaQuery.of(context).size.width * 0.025),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
