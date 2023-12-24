import 'package:flutter/material.dart';

class NameModel {
  String name;
  bool isSelectedText;

  NameModel(this.name, {this.isSelectedText = false});
}

class CoffeeDetailModel {
  AssetImage assetImage;
  String name;
  String detail;
  double price;
  double rating;

  CoffeeDetailModel(
      this.assetImage, this.name, this.detail, this.price, this.rating);
}
