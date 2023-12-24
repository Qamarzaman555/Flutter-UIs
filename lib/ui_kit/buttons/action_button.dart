import 'dart:ui';
import 'package:flutter/material.dart';

class CHIActionButton extends StatelessWidget {
  final Color? color;
  final Color? iconColor;
  final IconData? icon;
  final Widget? child;
  final VoidCallback? onTap;

  const CHIActionButton({
    super.key,
    this.color,
    this.icon,
    this.child,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color ?? Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: child ??
            (icon == null
                ? null
                : Icon(
                    icon!,
                    color: iconColor,
                  )),
      ),
    );
  }
}
