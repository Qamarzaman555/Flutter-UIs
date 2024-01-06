import 'dart:math';

import 'package:flutter/material.dart';
import 'package:practice/draggable/dragable_view/draggable_vm.dart';
import 'package:practice/ui_kit/local_pub.dart';
import 'package:stacked/stacked.dart';

class DraggableVU extends StackedView<DraggableVM> {
  const DraggableVU({super.key});

  @override
  Widget builder(BuildContext context, DraggableVM viewModel, Widget? child) {
    return Scaffold(
      appBar: const CHIAppBar(title: 'Draggavle'),
      body: Stack(
        children: [
          Positioned(
            left: viewModel.left,
            top: viewModel.top,
            child: GestureDetector(
              onTap: () {
                debugPrint('tapped');
              },
              onPanUpdate: (details) {
                viewModel.onUpdateValue(details);
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(50)),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  DraggableVM viewModelBuilder(BuildContext context) => DraggableVM();
}
