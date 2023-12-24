import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    int number = 5;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              calculationCard(
                  number, '$number * $counter', '${number * counter}'),
              12.spaceY,
              calculationCard(
                  number, '$number + $counter', '${number + counter}'),
              12.spaceY,
              calculationCard(
                  number, '$number - $counter', '${number - counter}'),
              20.spaceY,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  changeValueCard('+', incrementCounter),
                  Text('$counter'),
                  changeValueCard('-', decrementCounter),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget changeValueCard(String text, void Function()? onTap) {
    return CHICard(
      color: Colors.blue,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          text,
          style: CHIStyles.displayXsNormalStyle,
        ),
      ),
    );
  }

  Widget calculationCard(int number, String text, String calculate) {
    return CHICard(
      color: const Color.fromARGB(143, 220, 250, 129),
      child: Column(
        children: [
          Text(text),
          16.spaceY,
          CHITextField(
            borderRadius: 16,
            hintText: calculate,
          ),
        ],
      ),
    );
  }
}
