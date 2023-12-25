import 'package:flutter/material.dart';
import 'package:practice/animation_integration/main_view/main_view_vu.dart';

void main() {
  runApp(MaterialApp(
    home: const MainView(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
  ));
}
