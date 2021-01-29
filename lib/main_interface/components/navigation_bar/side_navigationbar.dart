import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/main_interface/screens/cart_screen/screens/cart_screen.dart';
import 'package:gimig_gastro_application/main_interface/screens/home_screen/screens/welcome_screen.dart';

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
            width: 100,
            height: 100,
            color: kBackgroundColor.withOpacity(0),
            child: Icon(
              Icons.arrow_back_ios,
              color: kDetailColor,
              size: 50,
            ),
          ),
        ),
        SizedBox(
          height: 300,
        ),
        GestureDetector(
            onTap: () {
              {
                Navigator.pushNamed(context, WelcomeScreen.id);
              }
            },
            child: Container(
                height: 100,
                width: 100,
                color: kBackgroundColor.withOpacity(0),
                child: Icon(
                  Icons.home,
                  size: 45,
                  color: kDetailColor,
                ))),
        // GestureDetector(
        //     onTap: () {
        //       Navigator.pushNamed(context, WelcomeScreen.id);
        //     },
        //     child: Container(
        //         height: 80,
        //         width: 80,
        //         color: kBackgroundColor.withOpacity(0),
        //         child: Icon(
        //           Icons.notifications_active,
        //           size: 35,
        //           color: kDetailColor,
        //         ))),
        GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, CartScreen.id);
            },
            child: Container(
                height: 100,
                width: 100,
                color: kBackgroundColor.withOpacity(0),
                child: Icon(
                  Icons.shopping_cart,
                  size: 45,
                  color: kDetailColor,
                ))),
      ],
    );
  }
}
