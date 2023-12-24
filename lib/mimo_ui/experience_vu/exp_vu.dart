import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

import 'package:stacked/stacked.dart';

import '../path_vu/pathA_vu.dart';
import 'exp_vm.dart';

class ExpereinceVU extends StackedView<ExperienceVM> {
  const ExpereinceVU({super.key});
  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'EXPERIENCE',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 40),
                child: Text(
                  textAlign: TextAlign.center,
                  'How much coding experience do you have?',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: viewModel.pageController,
                  itemCount: viewModel.maxSegments,
                  onPageChanged: (index) {
                    viewModel.updatePage(index);
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height / 5,
                        width: MediaQuery.sizeOf(context).width / 3.2,
                        child: const Image(
                          image: AssetImage('assets/brands/mimo.png'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              8.spaceY,
              Slider(
                label: viewModel.currentPage.toDouble() == 0
                    ? 'NONE'
                    : viewModel.currentPage.toDouble() == 1
                        ? 'A LITTLE'
                        : 'A LOT',
                value: viewModel.currentPage.toDouble(),
                onChanged: (double value) => viewModel.updateSlider(value),
                min: 0,
                max: viewModel.maxSegments.toDouble(),
                divisions: viewModel.maxSegments,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Text(
                  'You are about to start your journey',
                  style: TextStyle(
                    color: Colors.deepPurple.shade900,
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          CHIRouter.push(context, const PathVU());
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: Colors.deepPurple),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14.0),
                          child: Text(
                            'CONTINUE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  viewModelBuilder(BuildContext context) {
    return ExperienceVM();
  }
}
