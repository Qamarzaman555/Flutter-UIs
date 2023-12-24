import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

import 'package:stacked/stacked.dart';

import '../api_model/api_model.dart';
import 'post_api_vm.dart';

class PostApiVU extends StackedView<PostApiVM> {
  const PostApiVU({super.key});

  @override
  Widget builder(BuildContext context, PostApiVM viewModel, Widget? child) {
    return Scaffold(
      body: Center(
        child: viewModel.futureAlbum == null
            ? buildColumn(viewModel)
            : buildFutureBuilder(viewModel),
      ),
    );
  }

  Widget buildColumn(PostApiVM viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: viewModel.controller,
            decoration: const InputDecoration(hintText: 'Enter Title'),
          ),
          20.spaceY,
          ElevatedButton(
            onPressed: () {
              viewModel.onPostTitle();
            },
            child: const Text('Create Data'),
          ),
        ],
      ),
    );
  }

  FutureBuilder<Album> buildFutureBuilder(PostApiVM viewModel) {
    return FutureBuilder<Album>(
      future: viewModel.futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

  @override
  PostApiVM viewModelBuilder(BuildContext context) {
    return PostApiVM();
  }
}
