import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../mimo_model/models.dart';

class Path2VM extends BaseViewModel {
  MotiveModel? motive;

  List<MotiveModel> path2List = [
    MotiveModel(
        const Icon(
          Icons.computer_outlined,
          size: 32,
          color: Colors.deepPurple,
        ),
        'Games'),
    MotiveModel(
        const Icon(
          Icons.icecream_outlined,
          size: 32,
          color: Colors.deepPurple,
        ),
        'Web apps'),
    MotiveModel(
        const Icon(
          Icons.app_registration_outlined,
          size: 32,
          color: Colors.deepPurple,
        ),
        'I am not sure'),
  ];

  onSelectCard(index) {
    for (int i = 0; i < path2List.length; i++) {
      if (i == index) {
        path2List[index].isSelected = true;
        motive = path2List[index];
      } else {
        path2List[i].isSelected = false;
      }
    }
    notifyListeners();
  }
}
