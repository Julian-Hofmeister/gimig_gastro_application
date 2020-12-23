import 'package:flutter/material.dart';

class Item {
  Item(
      {this.image,
      this.name,
      this.price,
      this.description,
      this.amount = 1,
      this.ordered = false,
      this.isFood = true,
      this.id,
      this.imageFile});

  final String image;
  final String name;
  final String price;
  final String description;
  final String id;
  Widget imageFile;
  int amount;
  bool ordered;
  bool isFood;
}
