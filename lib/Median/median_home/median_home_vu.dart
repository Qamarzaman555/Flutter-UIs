import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import '../../ui_kit/local_pub.dart';
import '../median_home_form/median_form_vu.dart';
import 'median_home_vm.dart';

class MedianHomeVU extends StackedView<MedianHomeVM> {
  const MedianHomeVU({super.key});

  @override
  Widget builder(BuildContext context, MedianHomeVM viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        body: viewModel.artclesList.isEmpty
            ? Center(
                child: ElevatedButton(
                  onPressed: viewModel.isBusy
                      ? null
                      : () {
                          viewModel.getArticles();
                        },
                  child: viewModel.isBusy
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Fetch Data'),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: viewModel.artclesList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CHICard(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return MedianFormVU(
                                  article: viewModel.artclesList[index],
                                );
                              })).then((value) {
                                if (value != null) {
                                  viewModel.onUpdateItem(index, value);
                                }
                              });
                            },
                            width: MediaQuery.sizeOf(context).width,
                            color: Colors.amber,
                            child: Column(
                              children: [
                                textWidget(viewModel, index,
                                    'ID: ${viewModel.artclesList[index].id}'),
                                12.spaceY,
                                textWidget(viewModel, index,
                                    'Title:  ${viewModel.artclesList[index].title}'),
                                12.spaceY,
                                textWidget(viewModel, index,
                                    'Body: ${viewModel.artclesList[index].body}'),
                                12.spaceY,
                                textWidget(viewModel, index,
                                    'Description: ${viewModel.artclesList[index].description}'),
                                12.spaceY,
                                IconButton(
                                    onPressed: () {
                                      viewModel.onDeleteItem(index);
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return MedianFormVU();
            })).then((value) {
              if (value != null) {
                viewModel.onAddItem(value);
              }
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget textWidget(MedianHomeVM viewModel, int index, String text) {
    return Text(
      text,
      style: CHIStyles.xsBoldStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  MedianHomeVM viewModelBuilder(BuildContext context) {
    return MedianHomeVM();
  }
}
