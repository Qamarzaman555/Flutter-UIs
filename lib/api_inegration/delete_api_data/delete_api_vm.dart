import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';

import '../api_model/api_model.dart';

class DeleteApiVM extends BaseViewModel {
  late Future<Album> futureAlbum = fetchAlbum();
  Future<Album> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('Album is Empty');
    }
  }

  Future<Album> deleteAlbum(String id) async {
    final http.Response response = await http.delete(
      Uri.parse(
        'https://jsonplaceholder.typicode.com/albums/$id',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Item Not Deleted!');
    }
  }
}
