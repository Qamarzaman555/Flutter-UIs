import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'animated_container_vm.dart';

class AnimatedContainerVU extends StackedView<AnimatedContainerVM> {
  const AnimatedContainerVU({super.key});

  @override
  Widget builder(
          BuildContext context, AnimatedContainerVM viewModel, Widget? child) =>
      Scaffold(
        body: AnimatedOpacity(
          opacity: viewModel.opacity,
          duration: const Duration(seconds: 2),
          child: AnimatedContainer(
            duration: const Duration(seconds: 3),
            margin: EdgeInsets.all(viewModel.margin),
            color: viewModel.color,
            width: viewModel.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      viewModel.onChangeMargin();
                    },
                    child: const Text('Change Margin')),
                ElevatedButton(
                    onPressed: () {
                      viewModel.onChangeColor();
                    },
                    child: const Text('Change Color')),
                ElevatedButton(
                    onPressed: () {
                      viewModel.onChangeWidth();
                    },
                    child: const Text('Change Width')),
                ElevatedButton(
                    onPressed: () {
                      viewModel.onChangeOpacity();
                    },
                    child: const Text('Change Opacity')),
              ],
            ),
          ),
        ),
      );

  @override
  AnimatedContainerVM viewModelBuilder(BuildContext context) =>
      AnimatedContainerVM();
}
