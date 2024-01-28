// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';
import 'package:stacked/stacked.dart';

import 'crud_vm.dart';

class CrudVU extends StackedView<CrudVM> {
  const CrudVU({super.key});

  @override
  Widget builder(BuildContext context, CrudVM viewModel, Widget? child) {
    return Scaffold(
      body: ListView.builder(
        itemCount: viewModel.crudData.length,
        itemBuilder: (context, index) {
          return Container(
            margin: 4.padAll,
            padding: 4.padAll,
            color: Colors.amber,
            child: Row(
              children: [
                Text('${viewModel.crudData[index].name}'),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: context.kHeight / 3,
                              padding: 20.padAll,
                              width: double.infinity,
                              child: Form(
                                key: viewModel.formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      initialValue:
                                          viewModel.crudData[index].name,
                                      validator: viewModel.onValidate,
                                      onSaved: viewModel.onSaveName,
                                      decoration: const InputDecoration(
                                        hintText: 'Name',
                                        enabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                        errorBorder: OutlineInputBorder(),
                                      ),
                                    ),
                                    30.spaceY,
                                    ElevatedButton(
                                      onPressed: () {
                                        viewModel.onSubmit(context);
                                      },
                                      child: const Text('Submit'),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).then((value) {
                        if (value != null) {
                          viewModel.onUpdateName(index, value);
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.green,
                    )),
                IconButton(
                    onPressed: () {
                      viewModel.onRemoveName(index);
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    )),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: context.kHeight / 3,
                  padding: 20.padAll,
                  width: double.infinity,
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: viewModel.onValidate,
                          onSaved: viewModel.onSaveName,
                          decoration: const InputDecoration(
                            hintText: 'Name',
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(),
                          ),
                        ),
                        30.spaceY,
                        ElevatedButton(
                          onPressed: () {
                            viewModel.onSubmit(context);
                          },
                          child: const Text('Submit'),
                        )
                      ],
                    ),
                  ),
                );
              }).then((value) {
            if (value != null) {
              viewModel.onAddName(value);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  CrudVM viewModelBuilder(BuildContext context) => CrudVM();
}
