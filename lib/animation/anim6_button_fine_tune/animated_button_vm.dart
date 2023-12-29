import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'uk_anim_controller.dart';

class AnimatedButtonVM extends BaseViewModel {
  late UKAnimController ukWidthAnim;
  late UKAnimController ukOpacityAnim;
  late UKAnimController ukTickOpacityAnim;
  bool loadingInProgress = false;

  void initializeAnimationController() {
    ukWidthAnim =
        UKAnimController(duration: 300, tweenStart: 300, tweenEnd: 65);
    ukOpacityAnim = UKAnimController(duration: 300, tweenStart: 0, tweenEnd: 1);
    ukTickOpacityAnim = UKAnimController(duration: 300, tweenStart: 0, tweenEnd: 1);


    ukWidthAnim.controller.addStatusListener((status) async {
      print("ukWidthAnim status: $status");
      if (status == AnimationStatus.completed) {
        if (loadingInProgress == true) {
          ukOpacityAnim.controller.forward();
          await Future.delayed(const Duration(milliseconds: 500));
          ukTickOpacityAnim.controller.forward();
        } else {
          ukWidthAnim.controller.reverse();
        }
      }
    });

    ukTickOpacityAnim.controller.addStatusListener((status)  {
      print("ukTickOpacity status: $status");

      if (status == AnimationStatus.dismissed) {
        ukWidthAnim.controller.reverse();
      }
    });

   

   
  }

  @override
  void dispose() {
    ukWidthAnim.dispose();
    super.dispose();
  }

  callApi() async {
    ukWidthAnim.forward();
    loadingInProgress = true;
    await Future.delayed(const Duration(seconds: 2));
    loadingInProgress = false;
    print("Loading complete .....");
    ukOpacityAnim.controller.reverse();
    await Future.delayed(const Duration(seconds: 1));
    ukTickOpacityAnim.controller.reverse();

    

    

    
  }
}
