part of '../local_pub.dart';

class CHICard extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onTap;
  final Color? color;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;

  /// A generic Card used in whole app
  const CHICard({
    super.key,
    this.child,
    this.onTap,
    this.color,
    this.height,
    this.borderRadius,
    this.padding,
    this.width,
    this.boxShadow,
    this.margin,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? 0.padAll,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: border,
          boxShadow: boxShadow,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
        child: Material(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          color: color ?? Theme.of(context).extension<CHITheme>()?.cardColor,
          child: SizedBox(
            width: width,
            height: height,
            child: InkWell(
              onTap: onTap,
              borderRadius: borderRadius ?? BorderRadius.circular(8),
              child: Padding(
                padding: padding ?? const EdgeInsets.all(16),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
