import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'uk_anim_controller.dart';

class AnimatedButtonVM extends BaseViewModel {
  late UKAnimController ukWidthAnim;
  late UKAnimController ukProgresOpacityAnim;
  late UKAnimController ukTickOpacityAnim;
  bool loadingInProgress = false;

  void initializeAnimationController() {
    ukWidthAnim =
        UKAnimController(duration: 300, tweenStart: 300, tweenEnd: 65);
    ukProgresOpacityAnim = UKAnimController(duration: 300, tweenStart: 0, tweenEnd: 1);
    ukTickOpacityAnim = UKAnimController(duration: 300, tweenStart: 0, tweenEnd: 1);


    ukWidthAnim.controller.addStatusListener((status) async {

      debugPrint("ukWidthAnim status: $status");
      // debugPrint("ukWidthAnim status: $status");
      if (status == AnimationStatus.completed) {
        if (loadingInProgress == true) {

          ukProgresOpacityAnim.controller.forward();
          await Future.delayed(const Duration(milliseconds: 1200));

          ukTickOpacityAnim.controller.forward();
        } else {
          ukWidthAnim.controller.reverse();
        }
      }
    });

    ukProgresOpacityAnim.controller.addStatusListener((status) { 
      debugPrint("ukProgresOpacityAnim status: $status");
      // if(status == AnimationStatus.completed){}
     });

    ukTickOpacityAnim.controller.addStatusListener((status)  {
      debugPrint("ukTickOpacityAnim status: $status");


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
    await Future.delayed(const Duration(seconds: 1));
    loadingInProgress = false;
    // print("Loading complete .....");
    ukProgresOpacityAnim.controller.reverse();
    await Future.delayed(const Duration(seconds: 1));
    ukTickOpacityAnim.controller.reverse();

    

    

    
  }
}
