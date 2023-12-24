import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../home_vu/home_vu.dart';
import '../services/api_client.dart';

void main() {
  runApp(const MaterialApp(home: HomeVU()));
  GetIt.I.registerSingleton(ApiClient());
}
