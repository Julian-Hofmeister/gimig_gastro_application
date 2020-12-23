import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/classes/item_class.dart';
import 'package:gimig_gastro_application/dialogs/detail_dialog.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/services/firebase_storage_service.dart';
import 'package:gimig_gastro_application/services/image_cache_services.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path_provider/path_provider.dart';

Directory _appDocsDir;

class SmallCardConnected extends StatefulWidget {
  SmallCardConnected({this.item});
  final Item item;

  @override
  _SmallCardConnectedState createState() => _SmallCardConnectedState();
}

class _SmallCardConnectedState extends State<SmallCardConnected> {
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
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => DetailDialog(item: widget.item),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            width: 700,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 150,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
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
                      future: _getImage(context, widget.item.image),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          print("DATA: ${snapshot.data}");
                          if (snapshot.data != null) {
                            return Container(
                              child: snapshot.data,
                            );
                          } else {
                            Future.delayed(const Duration(milliseconds: 20),
                                () {
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
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 530,
                height: 180,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 450,
                          child: Text(
                            widget.item.name,
                            style:
                                kFoodCardTitleTextStyle.copyWith(fontSize: 25),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 350,
                          child: Text(
                            widget.item.description,
                            style: kFoodCardDescriptionTextStyle.copyWith(
                                fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          widget.item.price,
                          style: kFoodCardPriceTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
