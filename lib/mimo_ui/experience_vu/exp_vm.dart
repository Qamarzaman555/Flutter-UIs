import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ExperienceVM extends BaseViewModel {
  PageController pageController = PageController(initialPage: 0);
  int maxSegments = 2;
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void updateSlider(double value) {
    _currentPage = value.toInt();
    pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    notifyListeners();
  }

  void updatePage(int index) {
    _currentPage = index;
    notifyListeners();
  }
}
