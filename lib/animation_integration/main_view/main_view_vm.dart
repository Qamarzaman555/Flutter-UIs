import 'package:flutter/material.dart';
import 'package:practice/animation_integration/bedroom_view/animate_screen.dart';
import 'package:practice/animation_integration/model/model.dart';
import 'package:stacked/stacked.dart';

import '../bedroom_view/animate_vu.dart';
import 'main_view_vu.dart';

class MainViewModel extends BaseViewModel {
  onChanged(value, int index) {
    roomCondition[index].switchState = value;
    notifyListeners();
  }

  int selectedItemIndex = -1;

  void onSelectedItem(int index) {
    if (selectedItemIndex == index) {
      selectedItemIndex = -1;
    } else {
      selectedItemIndex = index;
    }

    notifyListeners();
    debugPrint('pressed');
  }

  List<PortionsModel> portionList = [
    PortionsModel(portionName: 'All', isSelected: false),
    PortionsModel(portionName: 'Living Room', isSelected: false),
    PortionsModel(portionName: 'Bedroom', isSelected: false),
    PortionsModel(portionName: 'Kitchen', isSelected: false),
  ];

  List<RoomCondition> roomCondition = [
    RoomCondition(
      roomCondIcon: Icons.light,
      roomCond: 'Smart Lightining',
      portionName: 'Bed Room',
      colors: Colors.blue.shade400,
      switchState: false,
      route: const AnimationScreen(),
    ),
    RoomCondition(
      roomCondIcon: Icons.air,
      roomCond: 'Air Condition',
      portionName: 'Living Room',
      colors: const Color.fromRGBO(102, 81, 76, 1),
      switchState: false,
      route: const Transition(),
    ),
    RoomCondition(
      roomCondIcon: Icons.directions_walk,
      roomCond: 'Motion Sensors',
      portionName: 'Kitchen',
      colors: Colors.orange.shade400,
      switchState: false,
      route: const MainView(),
    ),
    RoomCondition(
      roomCondIcon: Icons.desk,
      roomCond: 'Desk Lamp',
      portionName: 'Bedroom',
      colors: Colors.deepPurple.shade400,
      switchState: false,
      route: const MainView(),
    ),
  ];
}
