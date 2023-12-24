import 'package:flutter/material.dart';

class MotiveModel {
  Icon icon;
  String text;
  bool isSelected;

  MotiveModel(this.icon, this.text, {this.isSelected = false});
}

class Model {
  String text;

  Model(this.text);
}
