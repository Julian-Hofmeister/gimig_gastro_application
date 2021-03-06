import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gimig_gastro_application/main_interface/screens/item_screen/class/item_class.dart';

class CloudStorageService {
  final _firestore = FirebaseFirestore.instance;

  String getImageFileName({
    String title,
  }) {
    var imageFileName =
        title + DateTime.now().microsecondsSinceEpoch.toString();
    return imageFileName;
  }

  Future<CloudStorageResult> uploadImage({
    File imageToUpload,
    String imageFileName,
    String title,
    String name,
    String description,
    String price,
  }) async {
    var imageFileName = getImageFileName(title: title);
    await Firebase.initializeApp();

    print(name);
    print(description);
    print(price);
    print(imageFileName);

    _firestore.collection("menu").add({
      "name": name,
      "description": description,
      "price": price,
      "image": imageFileName,
    });

    Reference ref = FirebaseStorage.instance.ref().child(imageFileName);

    UploadTask uploadTask = ref.putFile(imageToUpload);

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      print('Snapshot state: ${snapshot.state}'); // paused, running, complete
      print('Progress: ${snapshot.totalBytes / snapshot.bytesTransferred}');
    }, onError: (Object e) {
      print(e); // FirebaseException
    });

    uploadTask.then((TaskSnapshot snapshot) {
      print('Upload complete!');
    }).catchError((Object e) {
      print(e); // FirebaseException
    });
    return null;
  }

  deleteFood(Item item) async {
    if (item.image != null) {
      Reference ref = FirebaseStorage.instance.ref().child(item.image);

      print(ref.name);

      await ref.delete();

      print('image deleted');
    }

    print("FoodID: ${item.id}");
    await FirebaseFirestore.instance.collection('menu').doc(item.id).delete();
    // foodDeleted(food);
  }
}

class CloudStorageResult {
  final String imageUrl;
  final String imageFileName;

  CloudStorageResult({this.imageFileName, this.imageUrl});
}
