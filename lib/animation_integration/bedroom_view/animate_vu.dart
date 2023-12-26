// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:practice/animation_integration/bedroom_view/animate_vm.dart';
import 'package:stacked/stacked.dart';

class Transition extends StatefulWidget {
  const Transition({super.key});

  @override
  State<Transition> createState() => _TransitionState();
}

class _TransitionState extends State<Transition>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat();

  // @override
  // void dispose() {
  //   super.dispose();
  //   animationController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    late final Animation<Offset> offsetAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(1, 0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    ));
    return AnimateVU(offsetAnimation);
  }
}

class AnimateVU extends StackedView<AnimateVM> {
  AnimateVU(this.position, {super.key});
  Animation<Offset> position;

  @override
  Widget builder(BuildContext context, AnimateVM viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Living Room'),
      ),
      body: Column(
        children: [
          SlideTransition(
            position: position,
            child: const FlutterLogo(
              size: 200,
            ),
          ),
          const Text('data'),
        ],
      ),
    );
  }

  @override
  AnimateVM viewModelBuilder(BuildContext context) => AnimateVM();
}
