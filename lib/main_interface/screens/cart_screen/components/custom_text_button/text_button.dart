import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main/constants.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    @required this.buttonText,
    this.buttonAction,
  });
  final String buttonText;
  final Function buttonAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.4,
      child: FlatButton(
        onPressed: buttonAction,
        child: Text(
          buttonText,
          style: kButtonTextStyle.copyWith(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        color: kAccentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
