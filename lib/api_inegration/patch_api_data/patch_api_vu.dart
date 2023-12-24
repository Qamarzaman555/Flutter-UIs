import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

import 'package:stacked/stacked.dart';

import 'patch_api_vm.dart';

class PatchApiVU extends StackedView<PatchApiVM> {
  const PatchApiVU({super.key});

  @override
  Widget builder(BuildContext context, PatchApiVM viewModel, Widget? child) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: viewModel.controller,
              decoration: const InputDecoration(hintText: 'Enter Title'),
            ),
            20.spaceY,
            ElevatedButton(
                child: const Text('Update Data'),
                onPressed: () {
                  viewModel.updateAlbum();
                }),
          ],
        ),
      ),
    );
  }

  @override
  PatchApiVM viewModelBuilder(BuildContext context) {
    return PatchApiVM();
  }
}
