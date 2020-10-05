import 'package:flutter/material.dart';
import 'file:///C:/Users/julia/AndroidStudioProjects/Flutter/gimig_gastro_application/lib/main/constants.dart';

class TextButton extends StatelessWidget {
  TextButton({
    @required this.buttonText,
    this.buttonAction,
    this.buttonHeigt = 50,
    this.buttonWidth = 350,
    this.textSize = 22,
    this.textColor = Colors.black87,
    this.backgroundColor = Colors.white,
  });
  final String buttonText;
  final Function buttonAction;
  final double buttonHeigt;
  final double buttonWidth;
  final double textSize;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeigt,
      width: buttonWidth,
      child: FlatButton(
        onPressed: buttonAction,
        child: Text(
          buttonText,
          style:
              kButtonTextStyle.copyWith(fontSize: textSize, color: textColor),
        ),
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),
      ),
    );
  }
}
