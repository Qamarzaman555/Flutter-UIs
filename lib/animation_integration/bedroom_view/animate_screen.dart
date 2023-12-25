// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:practice/animation_integration/bedroom_view/bedroom_vu.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Set up the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Set up the animation
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Start the animation
    _controller.forward();

    // Add a listener to handle animation completion
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animation completed, navigate to the next screen or show the rest of the content
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const BedRoomVU()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(248, 248, 250, 30),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color.fromRGBO(210, 208, 227, 100),
                  Color.fromRGBO(161, 157, 199, 100),
                  Color.fromRGBO(152, 145, 192, 100),
                ],
                tileMode: TileMode.mirror,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: MediaQuery.sizeOf(context).height / 2.5,
                  left: MediaQuery.of(context).size.width * _animation.value,
                  child: const Icon(
                    Icons.light,
                    size: 100,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
