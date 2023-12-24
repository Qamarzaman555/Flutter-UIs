import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_vm.dart';

class HomeVU extends StackedView<HomeVM> {
  const HomeVU({super.key});

  @override
  Widget builder(BuildContext context, HomeVM viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: viewModel.albums.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              updateDataBottomSheet(context, viewModel, index);
                            },
                            child: Card(
                                color: Colors.white70,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(children: [
                                      Row(children: [
                                        Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              textWidget(viewModel, index,
                                                  'ID: ${viewModel.albums[index].id}'),
                                              textWidget(viewModel, index,
                                                  'userID: ${viewModel.albums[index].userId}'),
                                              textWidget(viewModel, index,
                                                  'Title: ${viewModel.albums[index].title!}')
                                            ])),
                                        IconButton(
                                            onPressed: () {
                                              viewModel.onDeleteAlbum(index);
                                            },
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              color: Colors.red,
                                            ))
                                      ])
                                    ])))));
                  }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addDataBottomSheet(context, viewModel);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> addDataBottomSheet(BuildContext context, HomeVM viewModel) {
    return showModalBottomSheet(
        scrollControlDisabledMaxHeightRatio: double.infinity,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height / 2,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        textFieldWidget(
                          hintText: 'ID',
                          validator: viewModel.idValidator,
                          onSaved: viewModel.onIdSaved,
                        ),
                        const SizedBox(height: 8),
                        textFieldWidget(
                            hintText: 'UserID',
                            validator: viewModel.userIdValidator,
                            onSaved: viewModel.onUserIdSaved),
                        const SizedBox(height: 8),
                        textFieldWidget(
                            hintText: 'Title',
                            validator: viewModel.titleValidator,
                            onSaved: viewModel.onTitleSaved),
                        const SizedBox(height: 8),
                        ElevatedButton(
                            onPressed: () {
                              viewModel.onSaveForm(context);
                            },
                            child: const Text('Save'))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<dynamic> updateDataBottomSheet(
      BuildContext context, HomeVM viewModel, int index) {
    return showModalBottomSheet(
        scrollControlDisabledMaxHeightRatio: double.infinity,
        // isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
                height: MediaQuery.sizeOf(context).height / 2,
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                            key: viewModel.formKey,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  textFieldWidget(
                                      hintText: 'ID',
                                      validator: viewModel.idValidator,
                                      onSaved: viewModel.onIdSaved,
                                      initialValue: viewModel.albums[index].id
                                          .toString()),
                                  const SizedBox(height: 8),
                                  textFieldWidget(
                                      hintText: 'UserID',
                                      validator: viewModel.userIdValidator,
                                      onSaved: viewModel.onUserIdSaved,
                                      initialValue: viewModel
                                          .albums[index].userId
                                          .toString()),
                                  const SizedBox(height: 8),
                                  textFieldWidget(
                                      hintText: 'Title',
                                      validator: viewModel.titleValidator,
                                      onSaved: viewModel.onTitleSaved,
                                      initialValue:
                                          viewModel.albums[index].title),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                      onPressed: () {
                                        viewModel.onUpdateData(index, context);
                                      },
                                      child: const Text('Save'))
                                ]))))),
          );
        });
  }

  Widget textFieldWidget({
    String? hintText,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    String? initialValue,
  }) {
    return TextFormField(
      initialValue: initialValue,
      validator: validator,
      onSaved: onSaved,
      decoration:
          InputDecoration(hintText: hintText, border: OutlineInputBorder()),
    );
  }

  Widget textWidget(HomeVM viewModel, int index, String text) => Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  @override
  HomeVM viewModelBuilder(BuildContext context) {
    return HomeVM();
  }
}
