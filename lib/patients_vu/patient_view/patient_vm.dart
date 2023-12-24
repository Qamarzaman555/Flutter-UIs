import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'patients_nav_vu.dart';

class PatientVM extends BaseViewModel {
  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    const Text(
      'Index 0: Observations',
    ),
    const PatientsNavVU(),
    const Text(
      'Index 2: Call',
    ),
    const Text(
      'Index 4: Chat',
    ),
  ];
  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
