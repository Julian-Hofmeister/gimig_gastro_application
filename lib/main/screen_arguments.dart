import 'package:cloud_firestore/cloud_firestore.dart';

class ScreenArguments {
  final CollectionReference path;
  final String title;
  ScreenArguments({this.title, this.path});
}
