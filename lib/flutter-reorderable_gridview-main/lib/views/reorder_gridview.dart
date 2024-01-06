import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import '../data/data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Re-orderable Gridview"),
      ),
      body: ReorderableGridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        children: imagePaths
            .map((String path) => Card(
                  key: ValueKey(path),
                  child: Image.network(
                    path,
                    fit: BoxFit.cover,
                  ),
                ))
            .toList(),
        onReorder: (oldIndex, newIndex) {
          String path = imagePaths.removeAt(oldIndex);
          imagePaths.insert(newIndex, path);
          setState(() {});
        },
      ),
    );
  }
}
