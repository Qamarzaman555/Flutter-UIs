// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'animated_button_vm.dart';

enum ButtonState { init, loading, done }

class AnimatedButtonVU extends StackedView<AnimatedButtonVM> {
  double loadingOpacity = 0.0;

  AnimatedButtonVU({super.key});

  @override
  void onViewModelReady(AnimatedButtonVM viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.initializeAnimationController();
  }

  @override
  Widget builder(
      BuildContext context, AnimatedButtonVM viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: Title(color: Colors.black, child: Text("Animations")),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimatedBuilder(
              animation: viewModel.ukWidthAnim.controller,
              builder: (_, value) {
                return SizedBox(
                  // curve: Curves.easeIn,
                  width: viewModel.ukWidthAnim.tween.value,
                  height: 70,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      viewModel.successStatus = Random.secure().nextBool()
                          ? AnimatedBuilder(
                              animation: viewModel.ukTickOpacityAnim.controller,
                              builder: (context, snapshot) {
                                return Opacity(
                                  opacity:
                                      viewModel.ukTickOpacityAnim.tween.value,
                                  child: TickIndicator(viewModel: viewModel),
                                );
                              })
                          : AnimatedBuilder(
                              animation: viewModel.ukTickOpacityAnim.controller,
                              builder: (context, snapshot) {
                                return Opacity(
                                  opacity:
                                      viewModel.ukTickOpacityAnim.tween.value,
                                  child: CrossIndicator(viewModel: viewModel),
                                );
                              }),
                      AnimatedBuilder(
                          animation: viewModel.ukProgresOpacityAnim.controller,
                          builder: (context, snapshot) {
                            return Opacity(
                              opacity:
                                  viewModel.ukProgresOpacityAnim.tween.value,
                              child: ProgressIndicator(),
                            );
                          }),
                      payNowBtn(viewModel),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget payNowBtn(AnimatedButtonVM viewModel) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          textStyle: TextStyle(fontSize: 24, color: Colors.white),
          minimumSize: Size.fromHeight(72),
          shape: StadiumBorder()),
      child: FittedBox(
          child: AnimatedBuilder(
              animation: viewModel.ukWidthAnim.controller,
              builder: (context, snapshot) {
                return Opacity(
                    opacity: viewModel.ukWidthAnim.tween.value / 300,
                    child: Text("Pay Now"));
              })),
      onPressed: () async {
        viewModel.callApi();
      },
    );
  }

  @override
  AnimatedButtonVM viewModelBuilder(BuildContext context) {
    return AnimatedButtonVM();
  }
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(50)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: CircularProgressIndicator(
          // backgroundColor: Colors.red,
          color: Colors.white,
          // strokeWidth: 10,
        ),
      ),
    );
  }
}

class TickIndicator extends StatelessWidget {
  AnimatedButtonVM viewModel;
  TickIndicator({
    required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(50)),
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Transform.scale(
              scale: viewModel.ukTickOpacityAnim.tween.value,
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 36,
              ))),
    );
  }
}

class CrossIndicator extends StatelessWidget {
  AnimatedButtonVM viewModel;

  CrossIndicator({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(50)),
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Transform.scale(
              scale: viewModel.ukTickOpacityAnim.tween.value,
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 36,
              ))),
    );
  }
}
