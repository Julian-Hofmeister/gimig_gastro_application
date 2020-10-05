import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/components/elements/text_button.dart';
import 'package:gimig_gastro_application/objects/category_example.dart';
import 'package:gimig_gastro_application/screens/cart_screen.dart';
import 'file:///C:/Users/julia/AndroidStudioProjects/Flutter/gimig_gastro_application/lib/main/constants.dart';
import 'package:gimig_gastro_application/screens/overview_screen.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({this.name});
  static const String id = 'welcome_screen';
  String name;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/BackgroundImage.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Icon(
                  Icons.notifications_active,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, CartScreen.id);
              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 700,
                  child: GestureDetector(
                    // onDoubleTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => SettingsScreen(),
                    //     ),
                    //   );
                    // },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: "Willkommen bei",
                              style: kMainTitleTextStyle),
                          TextSpan(
                              text: " Venezia",
                              style: kMainTitleTextStyle.copyWith(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    TextButton(
                      textSize: 25,
                      buttonHeigt: 55,
                      buttonText: "Getränke",
                      buttonAction: () {
                        Navigator.of(context)
                            .pushNamed(OverviewScreen.id, arguments: beverages);
                      },
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      textSize: 25,
                      buttonHeigt: 55,
                      buttonText: "Speisen",
                      buttonAction: () {
                        Navigator.of(context).pushNamed(
                          OverviewScreen.id,
                          arguments: courses,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
