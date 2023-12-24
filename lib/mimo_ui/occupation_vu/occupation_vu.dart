import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

import 'package:stacked/stacked.dart';

import '../experience_vu/exp_vu.dart';
import 'occupation_vm.dart';

class OccupationVU extends StackedView<OccupationVM> {
  const OccupationVU({super.key});

  @override
  Widget builder(BuildContext context, OccupationVM viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'OCCUPATION',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
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
                    itemCount: viewModel.occupationList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          CHIRouter.push(context, const ExpereinceVU());
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
                                  viewModel.occupationList[index].icon,
                                  20.spaceX,
                                  Expanded(
                                    child: Text(
                                      viewModel.occupationList[index].text,
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
  OccupationVM viewModelBuilder(BuildContext context) {
    return OccupationVM();
  }
}
