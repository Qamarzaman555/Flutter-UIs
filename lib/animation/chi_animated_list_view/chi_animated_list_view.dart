// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CHIAnimatedListView extends StatefulWidget {
  Widget? child;
  int? itemCount;
  ScrollPhysics? physics;
  Duration? slideDuration;
  Duration? delayDuration;
  EdgeInsetsGeometry? padding;
  Duration? fadeInDuration;
  BorderRadiusGeometry? borderRadius;
  Curve slideCurve = Curves.fastLinearToSlowEaseIn;
  Curve fadeCurve = Curves.fastLinearToSlowEaseIn;

  CHIAnimatedListView({
    this.child,
    this.itemCount,
    this.physics,
    this.slideDuration,
    this.fadeInDuration,
    this.delayDuration,
    this.borderRadius,
    this.padding,
    super.key,
  });

  @override
  State<CHIAnimatedListView> createState() => _CHIAnimatedListViewState();
}

class _CHIAnimatedListViewState extends State<CHIAnimatedListView> {
  @override
  Widget build(BuildContext context) {
    Widget? child;
    int? itemCount;
    ScrollPhysics? physics;
    Duration? slideDuration;
    Duration? delayDuration;
    EdgeInsetsGeometry? padding;
    Duration? fadeInDuration;
    BorderRadiusGeometry? borderRadius;
    return AnimationLimiter(
      child: ListView.builder(
        padding: padding,
        physics: physics,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            delay: delayDuration,
            child: SlideAnimation(
              duration: slideDuration,
              curve: Curves.fastLinearToSlowEaseIn,
              child: FadeInAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: fadeInDuration,
                child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: borderRadius,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: child),
              ),
            ),
          );
        },
      ),
    );
  }
}
