import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

import 'package:stacked/stacked.dart';

import 'get_api_vm.dart';

class GetApiVU extends StackedView<GetApiVM> {
  const GetApiVU({super.key});

  @override
  Widget builder(BuildContext context, GetApiVM viewModel, Widget? child) {
    return Scaffold(
        body: viewModel.albums.isEmpty
            ? Center(
                child: ElevatedButton(
                    onPressed: viewModel.isBusy
                        ? null
                        : () {
                            viewModel.fetchAlbum();
                          },
                    child: viewModel.isBusy
                        ? const CircularProgressIndicator(strokeWidth: 2)
                        : const Text('Fetch Data')),
              )
            : ListView.builder(
                itemCount: viewModel.albums.length,
                itemBuilder: (context, index) {
                  return CHICard(
                    child: Column(
                      children: [
                        Text('Title: ${viewModel.albums[index].title}'),
                        Text('Id: ${viewModel.albums[index].id}'),
                      ],
                    ),
                  );
                }));
  }

  @override
  GetApiVM viewModelBuilder(BuildContext context) {
    return GetApiVM();
  }
}
