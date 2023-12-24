import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

import '../api_model/api_model.dart';

class PostApiVM extends BaseViewModel {
  final TextEditingController controller = TextEditingController();
  Future<Album>? futureAlbum;

  // Future<Album> fetchAlbum() async {
  //   final uri = Uri.parse('https://jsonplaceholder.typicode.com/albums/3');
  //   final response = await http.get(
  //     uri,
  //   );

  //   if (response.statusCode == 200) {
  //     return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  Future<Album> createAlbum(String title) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'title': title}),
    );

    if (response.statusCode == 201) {
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  onPostTitle() {
    futureAlbum = createAlbum(controller.text);
    notifyListeners();
  }
}
