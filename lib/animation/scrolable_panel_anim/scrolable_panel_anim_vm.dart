import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../1_uk_animated_controller/uk_anim_controller.dart';

class ScrolablePanelVM extends BaseViewModel {
  late UKAnimController animation1;
  bool value = false;

  void initializeAnimationController() {
    animation1 = UKAnimController(duration: 200, tweenStart: 0, tweenEnd: 20);

    animation1.controller.addStatusListener((status) {
      debugPrint('animation1: $status');
      if (status == AnimationStatus.completed) {}
    });
  }

  @override
  void dispose() {
    animation1.dispose();

    super.dispose();
  }
}
