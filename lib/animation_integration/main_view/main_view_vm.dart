import 'package:flutter/material.dart';
import 'package:practice/animation_integration/model/model.dart';
import 'package:stacked/stacked.dart';

class MainViewModel extends BaseViewModel {
  bool switchStates = true;
  onChanged(bool value) {
    switchStates = value;
    notifyListeners();
  }

  MainViewModel();

  List<PortionsModel> portionList = [
    PortionsModel(portionName: 'All'),
    PortionsModel(portionName: 'Living Room'),
    PortionsModel(portionName: 'Bedroom'),
    PortionsModel(portionName: 'Kitchen'),
    PortionsModel(portionName: 'Hall'),
    PortionsModel(portionName: 'Washroom'),
  ];

  List<RoomCondition> roomCondition = [
    RoomCondition(
      roomCondIcon: Icons.light,
      deviceIcon: Icons.wifi,
      roomCond: 'Smart Lightining',
      portionName: 'Bed Room',
      colors: Colors.blue.shade400,
    ),
    RoomCondition(
      roomCondIcon: Icons.air,
      deviceIcon: Icons.bluetooth,
      roomCond: 'Air Condition',
      portionName: 'Living Room',
      colors: const Color.fromRGBO(241, 241, 246, 255),
    ),
    RoomCondition(
      roomCondIcon: Icons.directions_walk,
      deviceIcon: Icons.bluetooth,
      roomCond: 'Motion Sensors',
      portionName: 'Kitchen',
      colors: Colors.orange.shade400,
    ),
    RoomCondition(
      roomCondIcon: Icons.desk,
      deviceIcon: Icons.wifi,
      roomCond: 'Desk Lamp',
      portionName: 'Bedroom',
      colors: Colors.deepPurple.shade400,
    ),
  ];
}
