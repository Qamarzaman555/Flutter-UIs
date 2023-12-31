import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'uk_anim_controller.dart';

class PageTransitionAnimVM extends BaseViewModel {
  late UKAnimController animation1;

  void initializeAnimationController() {
    animation1 = UKAnimController(duration: 200, tweenStart: 0, tweenEnd: 20);

    animation1.controller.addStatusListener((status) {
      debugPrint('animation1: $status');
      if (status == AnimationStatus.completed) {
        // value = true;
      }
    });
  }

  @override
  void dispose() {
    animation1.dispose();

    super.dispose();
  }
}
