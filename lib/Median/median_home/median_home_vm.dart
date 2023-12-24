// import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'median_home_model.dart';

class MedianHomeVM extends BaseViewModel {
  List<Articles> artclesList = [];

  getArticles() async {
    setBusy(true);
    final response = await http.get(
      Uri.parse('https://webhook.site/4da56a50-ffa9-4aab-9acf-329246dedec5'),
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (final i in data) {
        artclesList.add(Articles.fromJson(i));
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load Data');
    }
    setBusy(false);
  }

  onDeleteItem(int i) {
    artclesList.removeAt(i);
    notifyListeners();
  }

  onUpdateItem(int index, Articles article) {
    artclesList[index] = article;
    notifyListeners();
  }

  onAddItem(article) {
    artclesList.add(article);
    notifyListeners();
  }

  // final TextEditingController controller = TextEditingController();

  // Future<Article> updateAlbum() async {
  //   final response = await http.patch(
  //     Uri.parse('http://localhost:3000/articles'),
  //     headers: {'Content-Type': 'application/json; charset=UTF-8'},
  //     body: jsonEncode(<String, String>{'title': controller.text}),
  //   );

  //   if (response.statusCode == 200) {
  //     return Article.fromJson(
  //         jsonDecode(response.body) as Map<String, dynamic>);
  //   } else {
  //     throw Exception('Failed to update Data.');
  //   }
  // }
}
