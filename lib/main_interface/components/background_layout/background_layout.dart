import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main/constants.dart';

class BackgroundLayout extends StatelessWidget {
  BackgroundLayout({this.name});

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
                    Text(
                      name,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.08),
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                        fontSize: 60,
                        letterSpacing: 6,
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
