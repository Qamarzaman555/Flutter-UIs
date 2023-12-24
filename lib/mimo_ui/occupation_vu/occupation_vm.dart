import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../mimo_model/models.dart';

class OccupationVM extends BaseViewModel {
  List<MotiveModel> occupationList = [
    MotiveModel(
        const Icon(
          Icons.computer_outlined,
          size: 32,
          color: Colors.deepPurple,
        ),
        'Hight school student'),
    MotiveModel(
        const Icon(
          Icons.icecream_outlined,
          size: 32,
          color: Colors.deepPurple,
        ),
        'University student'),
    MotiveModel(
        const Icon(
          Icons.app_registration_outlined,
          size: 32,
          color: Colors.deepPurple,
        ),
        'Employee'),
    MotiveModel(
        const Icon(
          Icons.account_tree_outlined,
          size: 32,
          color: Colors.deepPurple,
        ),
        'Non of these'),
  ];
}
