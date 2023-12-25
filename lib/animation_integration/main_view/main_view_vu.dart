import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:practice/animation_integration/main_view/main_view_vm.dart';
import 'package:practice/constants/custom_text.dart';
import 'package:practice/ui_kit/local_pub.dart';
import 'package:stacked/stacked.dart';

class MainView extends StackedView<MainViewModel> {
  const MainView({super.key});

  @override
  Widget builder(BuildContext context, MainViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                  text: 'Manage Home', size: 14, color: Colors.grey),
              const Row(children: [
                CustomText(text: 'Hey,', size: 24),
                Expanded(
                    child: CustomText(
                        text: '  Qamar', size: 24, weight: FontWeight.w500)),
                CircleAvatar(child: Icon(Icons.person_outline))
              ]),
              20.spaceY,
              tempCard(),
              12.spaceY,
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 15,
                width: MediaQuery.sizeOf(context).width,
                child: portionCardList(viewModel),
              ),
              12.spaceY,
              SizedBox(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                child: GridView.builder(
                  itemCount: viewModel.roomCondition.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      color: viewModel.switchStates
                          ? viewModel.roomCondition[index].colors
                          : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  viewModel.roomCondition[index].roomCondIcon,
                                  color: viewModel.switchStates
                                      ? Colors.white
                                      : viewModel.roomCondition[index].colors,
                                  size: 40,
                                ),
                                Icon(
                                  viewModel.roomCondition[index].deviceIcon,
                                  color: viewModel.switchStates
                                      ? Colors.white
                                      : Colors.grey,
                                  size: 16,
                                ),
                              ],
                            ),
                            12.spaceY,
                            Text('${viewModel.roomCondition[index].roomCond}'),
                            Text(
                                '${viewModel.roomCondition[index].portionName}'),
                            // const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('ON'),
                                Switch(
                                  activeColor: Colors.grey.shade300,
                                  value: viewModel.switchStates,
                                  onChanged: (bool value) {
                                    viewModel.onChanged(value);
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget portionCardList(MainViewModel viewModel) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: 4.padAll,
      itemCount: viewModel.portionList.length,
      itemBuilder: (context, index) {
        return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: CustomText(
                text: viewModel.portionList[index].portionName.toString(),
                size: 16,
              ),
            ));
      },
    );
  }

  Widget tempCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(Icons.sunny, color: Colors.blue),
              reusableColumn('motion', '75%'),
              const VerticalDivider(color: Colors.grey, thickness: 0.7),
              const Icon(Icons.energy_savings_leaf, color: Colors.deepPurple),
              reusableColumn('energy', '75%'),
              const VerticalDivider(color: Colors.grey, thickness: 0.7),
              const Icon(Icons.thermostat, color: Colors.yellow),
              reusableColumn('temp', '24 C'),
            ],
          ),
        ),
      ),
    );
  }

  Widget reusableColumn(String condition, String temp) {
    return Column(
      children: [
        CustomText(
          text: condition,
          color: Colors.grey,
          size: 14,
        ),
        CustomText(
          text: temp,
          weight: FontWeight.w700,
        ),
      ],
    );
  }

  @override
  MainViewModel viewModelBuilder(BuildContext context) => MainViewModel();
}

// decoration: const BoxDecoration(
//   gradient: LinearGradient(
//     colors: [
//       Color.fromRGBO(224, 222, 234, 255),
//       Color.fromRGBO(196, 192, 218, 255),
//       Color.fromRGBO(154, 145, 191, 255),
//     ],
//     begin: Alignment.topCenter,
//     end: Alignment.bottomCenter,
//   ),
// ),
