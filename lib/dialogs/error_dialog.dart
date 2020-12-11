import 'package:flutter/material.dart';

class ErrorDialog extends StatefulWidget {
  ErrorDialog({this.tableNumber, this.isOffline});
  final int tableNumber;
  final bool isOffline;

  @override
  _ErrorDialogState createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
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
        child: Stack(
          children: [
            // if (widget.isOffline == true)
            Center(
              child: Text(
                "Es tut uns leid. Es scheint sie haben keine Internetverbindung.",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 55,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // if (widget.isOffline == false)
            //   Center(
            //     child: Text(
            //       "Die Internet Verbindung wurde wieder hergestellt!",
            //       style: TextStyle(
            //         fontSize: MediaQuery.of(context).size.width / 55,
            //       ),
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
            Align(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "schließen",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 55,
                    color: Colors.black54,
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
