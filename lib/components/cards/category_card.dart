import 'package:flutter/material.dart';
import 'file:///C:/Users/julia/AndroidStudioProjects/Flutter/gimig_gastro_application/lib/main/constants.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({this.name, this.image, this.buttonAction});
  final String name;
  final String image;
  final Function buttonAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonAction,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 360,
              height: 317,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(1)),
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(1),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              height: 90,
              width: 360,
              child: Center(
                child: Text(
                  name,
                  style: kFoodCardTitleTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
