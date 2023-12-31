// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'my_bottom_sheet.dart';
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
          Text(
            'Something',
            style: TextStyle(color: Colors.white, fontSize: 50),
          ),
          CustomBottomSheet(
            maxHeight: MediaQuery.sizeOf(context).height * 0.745,
            headerHeight: 50.0,
            header: sheetHeader(),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  spreadRadius: -1.0,
                  offset: Offset(0.0, 3.0)),
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4.0,
                  spreadRadius: -1.0,
                  offset: Offset(0.0, 0.0)),
            ],
            children: List.generate(10, (int index) => listItem(index)),
          )
        ],
      ),
    );
  }

  @override
  PageTransitionAnimVM viewModelBuilder(BuildContext context) {
    return PageTransitionAnimVM();
  }
}

Widget listItem(index) => Container(
      margin: EdgeInsets.symmetric(vertical: 50),
      width: double.infinity,
      height: 100.0,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          colorBox(index: (2 * index) + index + 1, color: Colors.red),
          colorBox(index: (2 * index) + index + 2, color: Colors.green),
          colorBox(index: (2 * index) + index + 3, color: Colors.blue),
        ],
      ),
    );

Container colorBox({required num index, required Color color}) {
  return Container(
    alignment: Alignment.center,
    width: 90,
    height: 90,
    color: color,
    child: Text(
      "list item $index",
      style: TextStyle(color: Colors.white),
    ),
  );
}

Widget backgroundImage(BuildContext context) {
  return SizedBox(
    height: MediaQuery.sizeOf(context).height,
    width: MediaQuery.sizeOf(context).width,
    child: Image.asset(
      'assets/images/hamdhulla-shakeeb-bOBM8CB4ZC4-unsplash.jpg',
      fit: BoxFit.fill,
    ),
  );
}

Widget sheetHeader() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 15),
    decoration: const BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 6.0, bottom: 8.0),
          width: 40.0, // 10.w
          height: 6.5, // 0.8.h
          decoration: BoxDecoration(
              color: Colors.black45, borderRadius: BorderRadius.circular(50)),
        ),
        //     // Text("Drag the header to see bottom sheet"),
      ],
    ),
  );
}
