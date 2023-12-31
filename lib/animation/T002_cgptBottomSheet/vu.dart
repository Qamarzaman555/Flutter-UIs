// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'vm.dart';

class VU extends StackedView<VM> {
  const VU({super.key});

  @override
  Widget builder(BuildContext context, VM viewModel, Widget? child) => Scaffold(
        appBar: AppBar(
          title: Text('Swipeable Bottom Sheet'),
        ),
        body: SwipeableBottomSheet(),
      );

  @override
  VM viewModelBuilder(BuildContext context) {
    return VM();
  }
}

class SwipeableBottomSheet extends StatelessWidget {
  const SwipeableBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          // Swipe down
          Navigator.of(context).pop();
        } else if (details.primaryVelocity! < 0) {
          // Swipe up
          _showBottomSheet(context);
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: Text(
            'Swipe up to show bottom sheet',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: Colors.white,
              child: ListView.builder(
                controller: scrollController,
                itemCount: 50,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
