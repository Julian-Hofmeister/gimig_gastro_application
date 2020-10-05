import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main/constants.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({
    this.buttonWidth = 200,
    this.buttonHeight = 50,
    this.buttonName,
    this.buttonAction,
  });

  final double buttonWidth;
  final double buttonHeight;
  final String buttonName;
  final Function buttonAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        onPressed: buttonAction,
        child: Text(
          buttonName,
          style: kFoodCardTitleTextStyle.copyWith(
              fontSize: 22, color: Colors.white),
        ),
        color: kAccentColor,
      ),
    );
  }
}
