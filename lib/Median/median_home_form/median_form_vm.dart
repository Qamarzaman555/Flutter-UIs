import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../median_home/median_home_model.dart';

class MedianFormVM extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  Articles? article;
  int? id;
  String? title;
  String? body;
  String? description;

  String? onIdValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Id is required';
    }
    return null;
  }

  String? onTitleValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }
    return null;
  }

  String? onBodyValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Body is required';
    }
    return null;
  }

  String? onDescriptioValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Descrition is requiered';
    }
    return null;
  }

  onIdSaved(String? value) {
    id = int.parse(value!);
  }

  onTitleSaved(String? value) {
    title = value!;
  }

  onBodySaved(String? value) {
    body = value!;
  }

  onDescrtionSaced(String? value) {
    description = value!;
  }

  onSavedForm(context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      article = Articles(
        id: id!,
        title: title!,
        body: body!,
        description: description!,
      );

      Navigator.pop(context, article);
    }
  }
}
