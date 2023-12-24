import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

import '../api_model/api_model.dart';

class PatchApiVM extends BaseViewModel {
  final TextEditingController controller = TextEditingController();

  Future<Album> updateAlbum() async {
    final response = await http.patch(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, String>{'title': controller.text}),
    );

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to update album.');
    }
  }
}
