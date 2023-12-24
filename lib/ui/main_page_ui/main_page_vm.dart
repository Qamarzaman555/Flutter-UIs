import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../model.dart';

class MainPageVM extends BaseViewModel {
  NameModel? text;
  CoffeeDetailModel? coffee;
  List<NameModel> textList = [
    NameModel('Cappuccino'),
    NameModel('Expresso'),
    NameModel('Red Eye'),
    NameModel('Black Eye'),
  ];

  List<CoffeeDetailModel> coffeeList = [
    CoffeeDetailModel(const AssetImage('assets/brands/cappuccino.png'),
        'Cappuccino', 'with Oat Milk', 4.20, 4.2),
    CoffeeDetailModel(const AssetImage('assets/brands/expresso.png'),
        'Expresso', 'with Chocolate', 5.10, 4.5),
    CoffeeDetailModel(const AssetImage('assets/brands/Red Eye.png'), 'Red Eye',
        'with Walnut', 6.10, 4.8),
    CoffeeDetailModel(const AssetImage('assets/brands/Black Eye.png'),
        'Black Eye', 'with Oat Milk', 6.10, 4.8),
  ];

  onSelectCard(index) {
    for (int i = 0; i < textList.length; i++) {
      if (i == index) {
        textList[index].isSelectedText = true;
        text = textList[index];
      } else {
        textList[i].isSelectedText = false;
      }
    }
    notifyListeners();
  }
}
