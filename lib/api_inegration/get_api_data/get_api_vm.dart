import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';

import '../api_model/api_model.dart';

class GetApiVM extends BaseViewModel {
  List<Album> albums = [];
  fetchAlbum() async {
    setBusy(true);
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      for (final album in body) {
        albums.add(Album.fromJson(album));
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load album');
    }
    setBusy(false);
  }
}
