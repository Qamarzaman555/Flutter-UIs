import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'median_vm.dart';

class MedianVU extends StackedView<MedianVM> {
  const MedianVU({super.key});

  @override
  Widget builder(BuildContext context, MedianVM viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: viewModel.getMedian(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Loading'));
              } else {
                return ListView.builder(
                    itemCount: viewModel.medianList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Text('${viewModel.medianList[index].id}'),
                            Text(viewModel.medianList[index].firstname),
                            Text(viewModel.medianList[index].lastname),
                            Text(viewModel.medianList[index].email),
                            Text(viewModel.medianList[index].birthDate),
                            Text(viewModel.medianList[index].login.uuid
                                .toString()),
                            Text(viewModel.medianList[index].address.street
                                .toString()),
                          ],
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }

  @override
  MedianVM viewModelBuilder(BuildContext context) {
    return MedianVM();
  }
}
