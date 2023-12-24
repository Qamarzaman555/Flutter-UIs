// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

import 'package:stacked/stacked.dart';

import '../median_home/median_home_model.dart';
import 'median_form_vm.dart';

class MedianFormVU extends StackedView<MedianFormVM> {
  MedianFormVU({super.key, this.article});
  Articles? article;

  @override
  Widget builder(BuildContext context, MedianFormVM viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textFieldWidget(
                    initialValue: article?.id.toString(),
                    hintText: 'ID',
                    validator: viewModel.onIdValidator,
                    onSaved: viewModel.onIdSaved),
                12.spaceY,
                textFieldWidget(
                    initialValue: article?.title,
                    hintText: 'Title',
                    validator: viewModel.onTitleValidator,
                    onSaved: viewModel.onTitleSaved),
                12.spaceY,
                textFieldWidget(
                    initialValue: article?.body,
                    hintText: 'Body',
                    validator: viewModel.onBodyValidator,
                    onSaved: viewModel.onBodySaved),
                12.spaceY,
                textFieldWidget(
                    initialValue: article?.description,
                    hintText: 'Description',
                    validator: viewModel.onDescriptioValidator,
                    onSaved: viewModel.onDescrtionSaced),
                12.spaceY,
                CHIButton(
                  lable: 'Save',
                  onTap: () {
                    viewModel.onSavedForm(context);
                  },
                  backgroundColor: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFieldWidget(
      {String? initialValue,
      String? hintText,
      dynamic Function(String?)? onSaved,
      String? Function(String?)? validator}) {
    return CHITextField(
      initialValue: initialValue,
      onSaved: onSaved,
      validator: validator,
      hintText: hintText,
      fillColor: Colors.amber,
      // filled: true,
    );
  }

  @override
  MedianFormVM viewModelBuilder(BuildContext context) {
    return MedianFormVM();
  }
}
