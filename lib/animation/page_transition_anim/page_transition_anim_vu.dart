// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:practice/constants/custom_text.dart';
import 'package:stacked/stacked.dart';

import 'page_transition_anim_vm.dart';

enum ButtonState { init, loading, done }

class PageTransitionAnimVU extends StackedView<PageTransitionAnimVM> {
  double loadingOpacity = 0.0;

  PageTransitionAnimVU({super.key});

  @override
  void onViewModelReady(PageTransitionAnimVM viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.initializeAnimationController();
  }

  @override
  Widget builder(
      BuildContext context, PageTransitionAnimVM viewModel, Widget? child) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          backgroundImage(context),
          CustomText(
            text: 'Something',
            color: Colors.white,
            size: 50,
          ),
          profileCard(viewModel),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (viewModel.value == true) {
            viewModel.animation1.controller.forward();
          } else {
            viewModel.animation1.controller.reverse();
          }
          viewModel.value = false;
        },
        label: Row(
          children: const [
            Icon(
              Icons.person,
              color: Colors.black45,
            ),
            CustomText(
              text: 'Profile',
              color: Colors.black45,
            )
          ],
        ),
      ),
    );
  }

  AnimatedBuilder profileCard(PageTransitionAnimVM viewModel) {
    return AnimatedBuilder(
        animation: viewModel.animation1.controller,
        builder: (context, snapshot) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: viewModel.animation1.tween.value,
              sigmaX: viewModel.animation1.tween.value,
            ),
            child: Center(
              child: Transform.scale(
                scale: viewModel.animation1.tween.value / 20,
                child: Container(
                  width: MediaQuery.sizeOf(context).width / 2,
                  height: MediaQuery.sizeOf(context).height / 2,
                  decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Colors.white)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.black12,
                        radius: 35,
                        child: Icon(
                          Icons.person_outline_rounded,
                          size: 30,
                          color: Colors.black45,
                        ),
                      ),
                      Column(
                        children: [
                          myTile(Icons.settings_outlined, 'Settings', () {},
                              context),
                          myTile(Icons.info_outline_rounded, 'About', () {},
                              context),
                          myTile(Icons.feedback_outlined, 'Feedback', () {},
                              context),
                          myTile(Icons.find_in_page_outlined, 'Privacy Policy',
                              () {}, context),
                        ],
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  PageTransitionAnimVM viewModelBuilder(BuildContext context) {
    return PageTransitionAnimVM();
  }

  Widget backgroundImage(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: Image.asset(
        'assets/onboard/hamdhulla-shakeeb-bOBM8CB4ZC4-unsplash.jpg',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget divider(BuildContext context) {
    return SizedBox(
      height: 5,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget myTile(
    IconData icon,
    String title,
    VoidCallback voidCallback,
    BuildContext context,
  ) {
    return Column(
      children: [
        ListTile(
          tileColor: Colors.black,
          leading: CircleAvatar(
            radius: 16,
            backgroundColor: Colors.black12,
            child: Icon(
              icon,
              color: Colors.black45,
              size: 16,
            ),
          ),
          onTap: voidCallback,
          title: Text(
            title,
            style: const TextStyle(
                color: Colors.black45,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
          ),
          trailing: const Icon(
            Icons.arrow_right,
            size: 20,
            color: Colors.black45,
          ),
        ),
        divider(context),
      ],
    );
  }
}
