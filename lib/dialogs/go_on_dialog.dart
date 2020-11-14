import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/screens/cart_screen.dart';

class GoOnDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      content: Container(
        width: 500,
        height: 250,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Dein Gericht wurde erfolgreich zum Einkaufswagen hinzugefügt!\n\nMöchtest du weiter Bestellen?",
              style: kFoodCardDescriptionTextStyle.copyWith(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                  height: 50,
                  child: FlatButton(
                    color: kAccentColor,
                    splashColor: Colors.white,
                    highlightColor: Colors.grey,
                    child: Text("Weiter",
                        style: kFoodCardDescriptionTextStyle.copyWith(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: OutlineButton(
                    borderSide: BorderSide(color: kAccentColor, width: 2),
                    color: Color(0xFFFF6633),
                    splashColor: Colors.white,
                    highlightColor: kAccentColor,
                    highlightedBorderColor: kAccentColor,
                    child: Text(
                      "Bestellung",
                      style: kFoodCardDescriptionTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, CartScreen.id);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
