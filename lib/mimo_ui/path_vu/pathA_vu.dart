import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

import 'package:stacked/stacked.dart';

import '../pathB_vu/pathB_vu.dart';
import 'pathA_vm.dart';

class PathVU extends StackedView<PathVM> {
  const PathVU({super.key});

  @override
  Widget builder(BuildContext context, PathVM viewModel, Widget? child) {
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
                    EdgeInsets.only(left: 26, right: 26, top: 44, bottom: 20),
                child: Text(
                  textAlign: TextAlign.center,
                  'Which aspect of coding captivates you?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              8.spaceY,
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.pathList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        viewModel.onSelectCard(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Card(
                          shape: !viewModel.pathList[index].isSelected
                              ? null
                              : RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                      width: 4, color: Colors.deepPurple)),
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            child: Row(
                              children: [
                                viewModel.pathList[index].icon,
                                20.spaceX,
                                Expanded(
                                  child: Text(
                                    viewModel.pathList[index].text,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: viewModel.motive == null
                          ? null
                          : () {
                              CHIRouter.push(context, const Path2VU());
                            },
                      style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: Colors.deepPurple.shade100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.deepPurple),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
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
  PathVM viewModelBuilder(BuildContext context) {
    return PathVM();
  }
}
