import 'package:flutter/material.dart';

class PortionsModel {
  String? portionName;

  PortionsModel({this.portionName});
}

class RoomCondition {
  IconData? roomCondIcon;
  IconData? deviceIcon;
  String? roomCond;
  String? portionName;
  bool switchState;
  Color? colors;

  RoomCondition({
    this.roomCondIcon,
    this.deviceIcon,
    this.roomCond,
    this.portionName,
    this.switchState = false,
    this.colors,
  });
}
