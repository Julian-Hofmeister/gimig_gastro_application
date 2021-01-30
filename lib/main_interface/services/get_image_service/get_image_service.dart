import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/services/firebase_storage_service.dart';
import 'package:gimig_gastro_application/services/image_cache_services.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path_provider/path_provider.dart';

class GetImageService {
  final ImageCacheService _imageCacheService = ImageCacheService();

  Directory appDocsDir;

  Future getDir() async {
    appDocsDir = await getApplicationDocumentsDirectory();
  }

  Future<Widget> getImage(BuildContext context, String imageName) async {
    Image image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image(
        image: NetworkToFileImage(
          file: _imageCacheService.fileFromDocsDir(imageName, appDocsDir),
          url: value.toString(),
          debug: true,
        ),
        fit: BoxFit.cover,
      );
      print(value.toString());
    });
    return image;
  }
}
