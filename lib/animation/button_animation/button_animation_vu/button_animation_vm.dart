import 'package:stacked/stacked.dart';

import 'button_animation_vu.dart';

class ButtonAnimationVM extends BaseViewModel {
  // ButtonAnimationVM() {
  //   changeOpacity();
  // }

  double width = 400;

  double opacityLevel = 0;

  bool isAnimating = true;

  bool isPressed = false;

  setOpacity() {
    opacityLevel = opacityLevel == 0 ? 1.0 : 0.0;
    notifyListeners();
  }

  resetOpacity() {
    opacityLevel = 0;
    notifyListeners();
  }

  ButtonState state = ButtonState.init;

  toggleAnimation() {
    isAnimating = !isAnimating;
    isPressed = !isPressed;
    notifyListeners();
  }

  loadingState() {
    state = ButtonState.loading;

    notifyListeners();
  }

  doneState() {
    state = ButtonState.done;
    notifyListeners();
  }

  initState() {
    state = ButtonState.init;
    notifyListeners();
  }
}
