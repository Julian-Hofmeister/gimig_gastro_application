import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.only(bottom: 60),
        child: Stack(
          children: <Widget>[
            Container(
              width: 650,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
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
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      bottomLeft: Radius.circular(60),
                    ),
                    color: Colors.white,
                  ),
                  height: 55,
                  width: 270,
                  child: Center(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
