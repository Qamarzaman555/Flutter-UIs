import 'package:flutter/material.dart';

import '../get_api_data/get_api_vu.dart';
// import 'patch_api_data/patch_api_vu.dart';
// import 'post_api_data/post_api_vu.dart';
// import 'delete_api_data/delete_api_vu.dart';

void main() {
  runApp(const MaterialApp(
    home: GetApiVU(),
    // home: PatchApiVU(),
    // home: PostApiVU(),
    // home: DeleteApiVU(),
  ));
}
