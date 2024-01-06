import 'dart:math';

import 'package:stacked/stacked.dart';

class DraggableVM extends BaseViewModel {
  double left = 0.0;
  double top = 0.0;
  DraggableVM();

  onUpdateValue(details) {
    left = max(0, left + details.delta.dx);
    top = max(0, top + details.delta.dy);
    notifyListeners();
  }
}
