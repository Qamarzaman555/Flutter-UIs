// ignore_for_file: prefer_const_constructors, must_be_immutable, unrelated_type_equality_checks

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:practice/constants/custom_text.dart';
import 'package:stacked/stacked.dart';

import 'scrolable_panel_anim_vm.dart';

class ScrolablePanelVU extends StackedView<ScrolablePanelVM> {
  const ScrolablePanelVU({super.key});

  @override
  void onViewModelReady(ScrolablePanelVM viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.initializeAnimationController();
  }

  @override
  Widget builder(
      BuildContext context, ScrolablePanelVM viewModel, Widget? child) {
    return Scaffold(
      body: GestureDetector(
          onVerticalDragEnd: (details) {
            double delta = details.primaryVelocity ?? 0;

            if (delta < 0) {
              // Swiped up
              showBottomSheet(context, viewModel);
              viewModel.animation1.controller.forward();
              debugPrint('Swiped up');
            } else if (delta > 0) {
              // Swiped down
              viewModel.animation1.reverse();
              debugPrint('Swiped down');
            }
          },
          child: backgroundImage(context, viewModel)),
    );
  }

  @override
  ScrolablePanelVM viewModelBuilder(BuildContext context) {
    return ScrolablePanelVM();
  }

  Widget backgroundImage(BuildContext context, ScrolablePanelVM viewModel) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Image.asset(
            'assets/onboard/hamdhulla-shakeeb-bOBM8CB4ZC4-unsplash.jpg',
            fit: BoxFit.fill,
          ),
        ),
        AnimatedBuilder(
            animation: viewModel.animation1.controller,
            builder: (context, snapshot) {
              return BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaY: viewModel.animation1.tween.value,
                  sigmaX: viewModel.animation1.tween.value,
                ),
                child: CustomText(
                  text: 'Something',
                  size: 40,
                  color: Colors.transparent,
                ),
              );
            }),
      ],
    );
  }

  void showBottomSheet(BuildContext context, ScrolablePanelVM viewModel) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 3,
            child: DraggableScrollableSheet(
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return ListView.builder(
                  // shrinkWrap: true,
                  controller: scrollController,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('Item $index'),
                    );
                  },
                );
              },
            ),
          );
        });
  }
}
