import 'package:flutter/material.dart';

class Category {
  Category({
    this.id,
    this.title,
    this.coverImage,
    this.items,
    this.description,
    this.food,
    this.pushScreen,
    this.content,
    this.hasSubcategory,
    this.imageFile,
  });

  final String coverImage;
  final String title;
  final String description;
  final pushScreen;
  final content;
  final String id;
  final bool hasSubcategory;
  Widget imageFile;
  List items;
  List food;
}
