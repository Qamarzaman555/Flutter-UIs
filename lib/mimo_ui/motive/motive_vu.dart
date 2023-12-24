import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

import 'package:stacked/stacked.dart';

import '../occupation_vu/occupation_vu.dart';
import 'motive_vm.dart';

class MotiveVU extends StackedView<MotiveVM> {
  const MotiveVU({super.key});

  @override
  Widget builder(BuildContext context, MotiveVM viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Motive',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(left: 26, right: 26, top: 64, bottom: 32),
                child: Text(
                  textAlign: TextAlign.center,
                  'Why are you learning to code?',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              8.spaceY,
              Expanded(
                child: ListView.builder(
                    itemCount: viewModel.motiveList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          CHIRouter.push(context, const OccupationVU());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Card(
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                              child: Row(
                                children: [
                                  viewModel.motiveList[index].icon,
                                  20.spaceX,
                                  Expanded(
                                    child: Text(
                                      viewModel.motiveList[index].text,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  MotiveVM viewModelBuilder(BuildContext context) {
    return MotiveVM();
  }
}
