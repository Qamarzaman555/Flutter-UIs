import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../median_model/median_model.dart';

class MedianVM extends BaseViewModel {
  List<Median> medianList = [];

  Future<List<Median>> getMedian() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.org/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (final i in data) {
        medianList.add(Median.fromJson(i));
      }
      notifyListeners();
      return medianList;
    } else {
      return medianList;
    }
  }
}
