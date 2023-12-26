// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:practice/dragable_card/dragable_card_vu/dragable_card_vm.dart';
import 'package:stacked/stacked.dart';

import 'animation.dart';

class DraggableCardVU extends StackedView<DraggableCardVM> {
  const DraggableCardVU({super.key});

  @override
  Widget builder(
      BuildContext context, DraggableCardVM viewModel, Widget? child) {
    return Scaffold(
      body: DraggableCard(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.fastLinearToSlowEaseIn,
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: const Color(0xff8639FB),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff8639FB).withOpacity(0.7),
                blurRadius: 30,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Drag it',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  DraggableCardVM viewModelBuilder(BuildContext context) {
    return DraggableCardVM();
  }
}
