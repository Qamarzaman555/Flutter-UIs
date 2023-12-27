import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AnimatedContainerVM extends BaseViewModel {
  double margin = 0;
  double width = 400;
  Color color = Colors.indigo;
  double opacity = 1;

  onChangeMargin() {
    margin == 50 ? margin = 0 : margin = 50;
    notifyListeners();
  }

  onChangeWidth() {
    width == 400 ? width = 600 : width = 400;
    notifyListeners();
  }

  onChangeColor() {
    color == Colors.indigo ? color = Colors.orange : color = Colors.indigo;
    notifyListeners();
  }

  onChangeOpacity() {
    opacity == 1 ? opacity = 0.5 : opacity = 1;
    notifyListeners();
  }
}
