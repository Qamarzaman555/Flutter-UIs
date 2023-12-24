// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

import 'person_model.dart';

class QamarTable extends StatelessWidget {
  bool isList;
  List<Person> persons;
  bool isDelete;
  Function(Person p)? onPress;

  QamarTable({
    super.key,
    this.isList = false,
    this.isDelete = false,
    this.onPress,
    required this.persons,
  });

  @override
  Widget build(BuildContext context) {
    return isList
        ? Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ListView.builder(
                  itemCount: persons.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(persons[index].name),
                                Text(persons[index].salary.toString()),
                              ],
                            ),
                            12.spaceY,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(persons[index].job),
                                GestureDetector(
                                  onTap: onPress == null
                                      ? null
                                      : () {
                                          onPress!(persons[index]);
                                        },
                                  child: isDelete
                                      ? const Icon(Icons.delete,
                                          color: Colors.red)
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          )
        : Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: persons.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: onPress == null
                                ? null
                                : () {
                                    onPress!(persons[index]);
                                  },
                            child: isDelete
                                ? const Icon(Icons.delete, color: Colors.red)
                                : const SizedBox.shrink(),
                          ),
                        ),
                        20.spaceY,
                        Text(persons[index].name),
                        12.spaceY,
                        Text(persons[index].job),
                        12.spaceY,
                        Text('${persons[index].salary}'),
                      ],
                    ),
                  );
                }),
          );
  }
}
