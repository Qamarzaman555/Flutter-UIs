import 'package:flutter/material.dart';

class ButtonController extends StatefulWidget {
  const ButtonController({super.key});

  @override
  State<ButtonController> createState() => _ButtonControllerState();
}

class _ButtonControllerState extends State<ButtonController>
    with TickerProviderStateMixin {
  bool isFav = false;
  late AnimationController controller;
  late Animation colorAnimation;
  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    colorAnimation = ColorTween(begin: Colors.grey.shade400, end: Colors.red)
        .animate(controller);

    // opacityController =
    //     AnimationController(vsync: this, duration: const Duration(seconds: 1));

    // animation = Tween<double>(begin: 500, end: 50).animate(widthController);

    // opacityAnimation =
    //     Tween<double>(begin: 0, end: 1).animate(opacityController);

    super.initState();
    controller.addListener(() {
      debugPrint('Controller Values: ${controller.value}');

      debugPrint('Animation Values: ${colorAnimation.value}');
    });

    controller.addStatusListener((status) {
      debugPrint('Controller Status: ${controller.status}');

      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          color: Colors.indigo,
          child: AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, _) {
              return IconButton(
                onPressed: () {
                  isFav ? controller.reverse() : controller.forward();
                },
                icon: Icon(
                  Icons.favorite,
                  color: colorAnimation.value,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
