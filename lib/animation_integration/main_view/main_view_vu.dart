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
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(248, 248, 250, 30),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            padding: const EdgeInsets.only(left: 12, right: 12, top: 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromRGBO(210, 208, 227, 100),
                  Color.fromRGBO(161, 157, 199, 100),
                  Color.fromRGBO(152, 145, 192, 100),
                ],
                tileMode: TileMode.mirror,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                    text: 'Manage Home', size: 14, color: Colors.black87),
                Row(children: [
                  const CustomText(text: 'Hey,', size: 24),
                  const Expanded(
                      child: CustomText(
                          text: '  Qamar', size: 24, weight: FontWeight.w500)),
                  useImageCard()
                ]),
                20.spaceY,
                tempCard(),
                4.spaceY,
                portionCardList(viewModel, context),
                4.spaceY,
                portionGridList(viewModel, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget portionGridList(MainViewModel viewModel, BuildContext contex) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: viewModel.roomCondition.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return portionDetailedCard(viewModel, context, index);
      },
    );
  }

  Widget portionDetailedCard(
      MainViewModel viewModel, BuildContext context, int index) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      curve: Easing.legacyDecelerate,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: viewModel.roomCondition[index].switchState
            ? viewModel.roomCondition[index].colors
            : Colors.white70,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  viewModel.roomCondition[index].roomCondIcon,
                  color: viewModel.roomCondition[index].switchState
                      ? Colors.white70
                      : viewModel.roomCondition[index].colors,
                  size: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return viewModel.roomCondition[index].route;
                    }));
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: viewModel.roomCondition[index].switchState
                        ? Colors.white70
                        : Colors.grey,
                    size: 16,
                  ),
                ),
              ],
            ),
            12.spaceY,
            CustomText(
              text: '${viewModel.roomCondition[index].roomCond}',
              weight: FontWeight.w600,
              color: viewModel.roomCondition[index].switchState
                  ? Colors.white
                  : Colors.black,
            ),
            CustomText(
              text: '${viewModel.roomCondition[index].portionName}',
              size: 14,
              color: viewModel.roomCondition[index].switchState
                  ? Colors.white
                  : Colors.grey.shade700,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text:
                      viewModel.roomCondition[index].switchState ? 'ON' : 'OFF',
                  size: 12,
                  color: viewModel.roomCondition[index].switchState
                      ? Colors.white
                      : Colors.black,
                ),
                Switch(
                  activeColor: Colors.grey.shade300,
                  value: viewModel.roomCondition[index].switchState,
                  onChanged: (value) {
                    viewModel.onChanged(value, index);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget useImageCard() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white70,
          radius: 32,
          child: Icon(
            Icons.person_outline,
            color: Colors.grey.shade300,
            size: 50,
          ),
        ),
        const CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 10,
          child: Icon(
            Icons.add,
            size: 16,
          ),
        ),
      ],
    );
  }

  Widget portionCardList(MainViewModel viewModel, BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 15,
      width: MediaQuery.sizeOf(context).width,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: 8.padAll,
        itemCount: viewModel.portionList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              viewModel.onSelectedItem(index);
            },
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: viewModel.selectedItemIndex == index
                        ? Colors.black12
                        : Colors.white70,
                    borderRadius: const BorderRadius.all(Radius.circular(32))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: CustomText(
                    text: viewModel.portionList[index].portionName.toString(),
                    size: 16,
                  ),
                )),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return 8.spaceX;
        },
      ),
    );
  }

  Widget tempCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(16),
      ),
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
