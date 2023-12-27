import 'package:flutter/material.dart';

class IconAnimation extends StatefulWidget {
  const IconAnimation({super.key});

  @override
  State<IconAnimation> createState() => _IconAnimationState();
}

class _IconAnimationState extends State<IconAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )
    ..forward()
    ..repeat(reverse: true);
  late Animation<double> animation =
      Tween<double>(begin: 0.0, end: 1.0).animate(controller);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 3),
      curve: Curves.linear,
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_home,
        progress: animation,
        color: Colors.white,
        size: 32.0,
      ),
    );
  }
}
