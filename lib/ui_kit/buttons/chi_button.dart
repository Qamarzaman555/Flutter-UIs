part of '../local_pub.dart';

class CHIButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool disabled;
  final String lable;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double? height;
  final bool loading;

  const CHIButton({
    this.onTap,
    required this.lable,
    this.backgroundColor,
    this.foregroundColor,
    this.disabled = false,
    this.loading = false,
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled || loading ? null : onTap,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
          backgroundColor: MaterialStateProperty.all<Color?>(backgroundColor)),
      child: loading
          ? ButtonLoader(foregroundColor ?? Colors.white)
          : Text(
              lable,
              style: CHIStyles.mdMediumStyle
                  .copyWith(color: foregroundColor ?? Colors.white),
              textAlign: TextAlign.center,
            ),
    );
  }
}
