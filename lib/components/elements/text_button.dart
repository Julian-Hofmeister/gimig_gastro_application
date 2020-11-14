import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main/constants.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    @required this.buttonText,
    this.buttonAction,
    this.buttonHeight = 50,
    this.buttonWidth = 350,
    this.textSize = 22,
    this.textColor = Colors.black87,
    this.backgroundColor = Colors.white,
  });
  final String buttonText;
  final Function buttonAction;
  final double buttonHeight;
  final double buttonWidth;
  final double textSize;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
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
