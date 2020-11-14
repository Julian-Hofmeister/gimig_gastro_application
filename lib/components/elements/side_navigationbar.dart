import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/screens/cart_screen.dart';
import 'package:gimig_gastro_application/screens/welcome_screen.dart';

// TODO BETTER NAVIGATION
class SideNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 80,
            height: 80,
            color: kBackgroundColor.withOpacity(0),
            child: Icon(
              Icons.arrow_back_ios,
              color: kAccentColor,
              size: 40,
            ),
          ),
        ),
        SizedBox(
          height: 250,
        ),
        GestureDetector(
            onTap: () {
              {
                Navigator.pushNamed(context, WelcomeScreen.id);
              }
            },
            child: Container(
                height: 80,
                width: 80,
                color: kBackgroundColor.withOpacity(0),
                child: Icon(
                  Icons.home,
                  size: 35,
                  color: kAccentColor,
                ))),
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, WelcomeScreen.id);
            },
            child: Container(
                height: 80,
                width: 80,
                color: kBackgroundColor.withOpacity(0),
                child: Icon(
                  Icons.notifications_active,
                  size: 35,
                  color: kAccentColor,
                ))),
        GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, CartScreen.id);
            },
            child: Container(
                height: 80,
                width: 80,
                color: kBackgroundColor.withOpacity(0),
                child: Icon(
                  Icons.shopping_cart,
                  size: 35,
                  color: kAccentColor,
                ))),
      ],
    );
  }
}
