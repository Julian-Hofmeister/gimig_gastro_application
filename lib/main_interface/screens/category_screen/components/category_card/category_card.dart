import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main_interface/screens/category_screen/class/category_class.dart';
import 'package:gimig_gastro_application/main/screen_arguments.dart';
import 'package:gimig_gastro_application/main_interface/screens/category_screen/screens/category_screen_connected.dart';
import 'package:gimig_gastro_application/main_interface/screens/item_screen/screens/item_screen_connected.dart';
import 'package:gimig_gastro_application/services/firebase_storage_service.dart';
import 'package:gimig_gastro_application/services/image_cache_services.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path_provider/path_provider.dart';

Directory _appDocsDir;

class CategoryCard extends StatefulWidget {
  CategoryCard({this.category, this.path});
  final Category category;
  final CollectionReference path;

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  final ImageCacheService _imageCacheService = ImageCacheService();

  Future _getDir() async {
    _appDocsDir = await getApplicationDocumentsDirectory();
  }

  void initState() {
    super.initState();
    _getDir();
  }

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image(
        image: NetworkToFileImage(
          file: _imageCacheService.fileFromDocsDir(imageName, _appDocsDir),
          url: value.toString(),
          debug: true,
        ),
        fit: BoxFit.cover,
      );
      print(value.toString());
      widget.category.imageFile = image;
    });
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.category.hasSubcategory == true) {
          Navigator.pushNamed(
            context,
            CategoryScreenConnected.id,
            arguments: ScreenArguments(
              path: widget.path
                  .doc(widget.category.title)
                  .collection("categories"),
              title: widget.category.title,
            ),
          );
        } else {
          Navigator.pushNamed(
            context,
            ItemScreenConnected.id,
            arguments: ScreenArguments(
              path: widget.path,
              title: widget.category.title,
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Stack(
          children: <Widget>[
            Container(
              width: 650,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FutureBuilder(
                    future: _getImage(context, widget.category.coverImage),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        print("DATA: ${snapshot.data}");
                        if (snapshot.data != null) {
                          return Container(
                            child: snapshot.data,
                          );
                        } else {
                          Future.delayed(const Duration(milliseconds: 20), () {
                            setState(() {});
                          });
                        }
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          child: snapshot.data,
                        );
                      } else {}
                      return Container(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ),
            Container(
              width: 650,
              height: 350,
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
                      widget.category.title,
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
