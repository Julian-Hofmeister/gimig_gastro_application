import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main/constants.dart';

class CustomSelectButton extends StatelessWidget {
  CustomSelectButton({this.option, this.buttonAction, this.title, this.isTrue});

  final bool option;
  final Function buttonAction;
  final String title;
  final bool isTrue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          width: 250,
          height: 50,
          decoration: BoxDecoration(
            color: option == isTrue ? Colors.blueGrey[300] : Colors.grey[300],
            borderRadius: BorderRadius.all(
              Radius.circular(60),
            ),
          ),
          child: Center(
              child: Text(
            title,
            style: kFoodCardDescriptionTextStyle.copyWith(
              color: option == isTrue ? Colors.white : Colors.black87,
            ),
          )),
        ),
        onTap: buttonAction);
  }
}
