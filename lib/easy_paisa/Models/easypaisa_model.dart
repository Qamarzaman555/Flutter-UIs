import 'package:flutter/material.dart';

class EasyPaisaCard {
  String name;
  IconData icon;

  EasyPaisaCard({required this.name, required this.icon});
}

class DebitCards {
  String name;
  String text;
  Color color;
  Widget toRoute;

  DebitCards({
    required this.name,
    required this.text,
    required this.color,
    required this.toRoute,
  });
}

class AccountDetails {
  String text;
  IconData icon1;
  IconData icon2;
  Widget? toRoute;

  AccountDetails({
    this.toRoute,
    required this.icon1,
    required this.text,
    required this.icon2,
  });
}
