// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice/api_client/services/api_client.dart';
import 'package:stacked/stacked.dart';

import '../models/model.dart';

class HomeVM extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  Model album = Model();
  String? title;
  int? userId;
  int? id;
  final _client = GetIt.I.get<ApiClient>();
  List<Model> albums = [];
  HomeVM() {
    getPosts();
  }

  Future<void> getPosts() async {
    setBusy(true);
    final resp = await _client.get(
      endpoint: '/albums',
      request: {'facility': true},
      fromJson: ParentModel.fromJson,
    );
    setBusy(false);
    if (resp.status == 'Ok') {
      albums = resp.data?.data ?? [];
    }
  }

  onDeleteAlbum(int i) {
    albums.removeAt(i);
    notifyListeners();
  }

  onUpdateData(int index, BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      album = Model(
        id: id!,
        userId: userId!,
        title: title!,
      );
      albums[index] = album;
    }
    notifyListeners();
    Navigator.pop(context);
  }

  // onAddData(album) {
  //   albums.insert(0, album);
  //   notifyListeners();
  // }

  String? titleValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }
    return null;
  }

  String? idValidator(value) {
    if (value == null || value.isEmpty) {
      return 'ID is required';
    }
    return null;
  }

  String? userIdValidator(value) {
    if (value == null || value.isEmpty) {
      return 'ID is required';
    }
    return null;
  }

  onTitleSaved(String? value) {
    title = value;
  }

  onUserIdSaved(String? value) {
    userId = int.parse(value!);
  }

  onIdSaved(String? value) {
    id = int.parse(value!);
  }

  onSaveForm(context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      album = Model(
        id: id!,
        userId: userId!,
        title: title!,
      );
      albums.insert(0, album);
    }
    notifyListeners();
    Navigator.pop(context);
  }
}
