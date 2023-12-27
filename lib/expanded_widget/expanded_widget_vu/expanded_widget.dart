// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class MyCustomWidget extends StatefulWidget {
  const MyCustomWidget({super.key});

  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  bool isTapped = true;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 300,
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                setState(() {
                  isTapped = !isTapped;
                });
              },
              onHighlightChanged: (value) {
                setState(() {
                  isExpanded = value;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                height: isTapped
                    ? isExpanded
                        ? 85
                        : 100
                    : isExpanded
                        ? 225
                        : 275,
                width: isExpanded ? 385 : 390,
                decoration: BoxDecoration(
                  color: const Color(0xff6F12E8),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff6F12E8).withOpacity(0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: isTapped
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Tap to Expand it',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400),
                              ),
                              Icon(
                                isTapped
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_up,
                                color: Colors.white,
                                size: 27,
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Tap to Expand it',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400),
                              ),
                              Icon(
                                isTapped
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_up,
                                color: Colors.white,
                                size: 27,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          isTapped
                              ? const Text('')
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Widgets that have global keys reparent their subtrees when they are moved from one location in the tree to another location in the tree. In order to reparent its subtree, a widget must arrive at its new location in the tree in the same animation frame in which it was removed from its old location the tree',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
