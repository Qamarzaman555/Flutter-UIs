part of '../local_pub.dart';

class CHIShadeCard extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  const CHIShadeCard({
    super.key,
    this.child,
    this.color,
    this.height,
    this.width,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(12),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).extension<CHITheme>()?.secondryColor,
        borderRadius: borderRadius ??
            const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
      ),
      child: child,
    );
  }
}
