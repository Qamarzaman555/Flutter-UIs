import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'rest_api_vm.dart';

class RestApiVU extends StackedView<RestApiVM> {
  const RestApiVU({super.key});

  @override
  Widget builder(BuildContext context, RestApiVM viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest APi'),
      ),
      body: viewModel.photoModel.isEmpty
          ? Center(
              child: ElevatedButton(
                  onPressed: () {
                    viewModel.fetchData();
                  },
                  child: const Text('Fetch Data')))
          : ListView.builder(
              itemCount: viewModel.photoModel.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: Colors.grey.shade300,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Album ID: ${viewModel.photoModel[index].albumId}'),
                          Text('ID: ${viewModel.photoModel[index].id}'),
                          Text(
                            'Title: ${viewModel.photoModel[index].title}',
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text('Url: ${viewModel.photoModel[index].url}'),
                          Text(
                            'Thumbnail Url: ${viewModel.photoModel[index].thumbnailUrl}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  @override
  RestApiVM viewModelBuilder(BuildContext context) {
    return RestApiVM();
  }
}
