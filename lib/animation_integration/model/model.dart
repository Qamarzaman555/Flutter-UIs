import 'package:flutter/material.dart';

class PortionsModel {
  String? portionName;
  bool isSelected;

  PortionsModel({
    this.portionName,
    this.isSelected = false,
  });
}

class RoomCondition {
  IconData? roomCondIcon;
  String? roomCond;
  String? portionName;
  bool switchState;
  Color? colors;
  Widget route;

  RoomCondition({
    this.roomCondIcon,
    this.roomCond,
    this.portionName,
    this.switchState = false,
    this.colors,
    required this.route,
  });
}
