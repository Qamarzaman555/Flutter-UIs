import 'dart:convert';

import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

import 'fetch_model.dart';

class RestApiVM extends BaseViewModel {
  // RestApiVM() {
  //   fetchData();
  // }
  List<PhotosModel> photoModel = [];
  fetchData() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (final photo in data) {
        photoModel.add(PhotosModel.fromJson(photo));
      }
    }
    notifyListeners();
  }
}
