import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import '../api_model/api_model.dart';
import 'delete_api_vm.dart';

class DeleteApiVU extends StackedView<DeleteApiVM> {
  const DeleteApiVU({super.key});

  @override
  Widget builder(BuildContext context, DeleteApiVM viewModel, Widget? child) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Album>(
          future: viewModel.futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(snapshot.data!.title),
                    ElevatedButton(
                      child: const Text('Delete Data'),
                      onPressed: () {
                        viewModel.futureAlbum =
                            viewModel.deleteAlbum(snapshot.data!.id.toString());
                        viewModel.notifyListeners();
                      },
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  @override
  DeleteApiVM viewModelBuilder(BuildContext context) {
    return DeleteApiVM();
  }
}
