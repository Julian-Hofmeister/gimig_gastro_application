import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main/constants.dart';

class SettingCategory extends StatelessWidget {
  SettingCategory(
      {this.backgroundColor = Colors.white,
      this.borderColor = Colors.white,
      this.icon,
      this.name,
      this.buttonAction});

  final Color backgroundColor;
  final Color borderColor;
  final String icon;
  final String name;
  final Function buttonAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonAction,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 73,
            backgroundColor: borderColor,
            child: CircleAvatar(
              radius: 70,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset(icon),
              ),
              backgroundColor: backgroundColor,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            name,
            style: kFoodCardDescriptionTextStyle.copyWith(
                color: Colors.white, fontSize: 20),
          )
        ],
      ),
    );
  }
}
