// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:practice/animation/favourite_btn/favourite_btn/favourite_btn_vm.dart';
import 'package:stacked/stacked.dart';

class FavoutriteBtnVU extends StackedView<FavouriteButtonVM> {
  const FavoutriteBtnVU({
    super.key,
  });

  @override
  Widget builder(
      BuildContext context, FavouriteButtonVM viewModel, Widget? child) {
    bool isFav = false;

    AnimationController controller = AnimationController(
      vsync: VsynC(),
      duration: const Duration(milliseconds: 500),
    );

    Animation colorAnimation =
        ColorTween(begin: Colors.grey.shade400, end: Colors.red)
            .animate(controller);

    controller.addStatusListener(
      (status) {
        debugPrint('Controller Status: ${controller.status}');

        if (status == AnimationStatus.completed) {
          isFav = true;
          viewModel.notifyListeners();
        }
        if (status == AnimationStatus.dismissed) {
          isFav = false;
          viewModel.notifyListeners();
        }
      },
    );

    return Scaffold(
      body: Center(
        child: Card(
          color: Colors.indigo,
          child: AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, _) {
              debugPrint('${controller.value}');
              return IconButton(
                onPressed: () {
                  isFav ? controller.reverse() : controller.forward();
                  viewModel.notifyListeners();
                },
                icon: Icon(
                  Icons.favorite,
                  color: colorAnimation.value,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  FavouriteButtonVM viewModelBuilder(BuildContext context) =>
      FavouriteButtonVM();
}

class VsynC extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker((elapsed) {});
  }
}
