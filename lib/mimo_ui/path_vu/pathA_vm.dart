import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../mimo_model/models.dart';

class PathVM extends BaseViewModel {
  MotiveModel? motive;
  List<MotiveModel> pathList = [
    MotiveModel(
        const Icon(
          Icons.computer_outlined,
          size: 32,
          color: Colors.deepPurple,
        ),
        'How things look (appearnce)'),
    MotiveModel(
        const Icon(
          Icons.icecream_outlined,
          size: 32,
          color: Colors.deepPurple,
        ),
        'How things work (logic)'),
    MotiveModel(
        const Icon(
          Icons.app_registration_outlined,
          size: 32,
          color: Colors.deepPurple,
        ),
        'I am intrigued by both'),
  ];
  onSelectCard(index) {
    for (int i = 0; i < pathList.length; i++) {
      if (i == index) {
        pathList[index].isSelected = true;
        motive = pathList[index];
      } else {
        pathList[i].isSelected = false;
      }
    }
    notifyListeners();
  }
}
