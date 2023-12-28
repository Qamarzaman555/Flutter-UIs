import 'package:flutter/material.dart';
import 'package:practice/animation/tweens_animation/tween/tween_vm.dart';
import 'package:stacked/stacked.dart';

class TweenVU extends StackedView<TweenVM> {
  const TweenVU({super.key});

  @override
  Widget builder(BuildContext context, TweenVM viewModel, Widget? child) =>
      Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 4),
              builder: (BuildContext context, double val, Widget? child) {
                return Opacity(
                  opacity: val,
                  child: Padding(
                    padding: EdgeInsets.only(top: val * 180),
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width / 2,
                        child: child
                        // Text('${val}'),
                        ),
                  ),
                );
              },
              child: const Text(
                'Slidable Text',
                style: TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );

  @override
  TweenVM viewModelBuilder(BuildContext context) => TweenVM();
}
