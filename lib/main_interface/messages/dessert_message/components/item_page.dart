import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/main_interface/components/order_button/order_button.dart';
import 'package:gimig_gastro_application/main_interface/dialogs/go_on_dialog.dart';
import 'package:gimig_gastro_application/main_interface/screens/cart_screen/class/shopping_cart.dart';
import 'package:gimig_gastro_application/main_interface/screens/item_screen/class/item_class.dart';
import 'package:gimig_gastro_application/services/firebase_storage_service.dart';
import 'package:gimig_gastro_application/services/image_cache_services.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path_provider/path_provider.dart';

Directory _appDocsDir;

class ItemPage extends StatefulWidget {
  ItemPage({this.item});

  final Item item;

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
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
      widget.item.imageFile = image;
    });
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      contentPadding: EdgeInsets.all(0),
      content: Container(
        width: 800,
        height: 450,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 250,
                  height: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(230),
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: widget.item.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(230),
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(20),
                          ),
                          child: FutureBuilder(
                              future: _getImage(context, widget.item.image),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  print("DATA: ${snapshot.data}");
                                  if (snapshot.data != null) {
                                    return Container(
                                      child: snapshot.data,
                                    );
                                  } else {
                                    Future.delayed(
                                        const Duration(milliseconds: 20), () {
                                      setState(() {});
                                    });
                                  }
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    child: snapshot.data,
                                  );
                                } else {}
                                return Container(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                        )
                      : null,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: 400,
                        alignment: Alignment.centerLeft,
                        child: Title(
                          child: Text(
                            widget.item.name,
                            style: kFoodCardTitleTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 400,
                        child: Text(
                          widget.item.description,
                          style: kFoodCardDescriptionTextStyle.copyWith(
                              fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          OrderButton(
                            buttonIcon: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 20,
                            ),
                            buttonName: "-",
                            buttonWidth: 50,
                            buttonHeight: 50,
                            buttonAction: () {
                              setState(() {
                                if (widget.item.amount > 1) {
                                  widget.item.amount--;
                                }
                              });
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          OrderButton(
                            buttonIcon: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                            buttonName: "+",
                            buttonWidth: 50,
                            buttonHeight: 50,
                            buttonAction: () {
                              setState(() {
                                if (widget.item.amount < 30) {
                                  widget.item.amount++;
                                }
                              });
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Anzahl: ${widget.item.amount}",
                            style:
                                kFoodCardTitleTextStyle.copyWith(fontSize: 24),
                          ),
                        ],
                      ),
                      OrderButton(
                        buttonHeight: 50,
                        buttonName: "Hinzufügen",
                        buttonAction: () {
                          setState(
                            () {
                              showDialog(
                                  context: (context),
                                  builder: (_) => GoOnDialog());

                              var i = 0;
                              while (i < widget.item.amount) {
                                if (shoppingCart.shoppingList
                                    .contains(widget.item)) {
                                  shoppingCart.shoppingList.remove(widget.item);
                                }
                                shoppingCart.shoppingList
                                    .insert(0, widget.item);

                                print(shoppingCart.shoppingList);
                                i++;
                              }
                            },
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
      ),
    );
  }
}
