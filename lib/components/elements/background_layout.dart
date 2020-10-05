import 'package:flutter/material.dart';
import 'file:///C:/Users/julia/AndroidStudioProjects/Flutter/gimig_gastro_application/lib/main/constants.dart';

class Backgroundlayout extends StatelessWidget {
  Backgroundlayout({this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Container(
            color: kBackgroundColor,
            child: Column(),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: kAccentColor,
            child: Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Opacity(
                      opacity: 0.09,
                      child: Text(
                        name,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          fontSize: 80,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
