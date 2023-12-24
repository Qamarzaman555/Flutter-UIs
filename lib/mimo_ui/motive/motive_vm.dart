import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../mimo_model/models.dart';

class MotiveVM extends BaseViewModel {
  List<MotiveModel> motiveList = [
    MotiveModel(
        const Icon(
          Icons.computer_outlined,
          size: 32,
          color: Colors.deepPurple,
        ),
        'To become a professional developer'),
    MotiveModel(
        const Icon(
          Icons.icecream_outlined,
          size: 32,
          color: Colors.deepPurple,
        ),
        'Just for fun'),
    MotiveModel(
        const Icon(
          Icons.app_registration_outlined,
          size: 32,
          color: Colors.deepPurple,
        ),
        'For my current job'),
    MotiveModel(
        const Icon(
          Icons.account_tree_outlined,
          size: 32,
          color: Colors.deepPurple,
        ),
        'For a different reason'),
  ];
}
