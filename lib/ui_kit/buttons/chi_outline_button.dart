part of '../local_pub.dart';

// ignore: must_be_immutable
class CHIOutlinedButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool disabled;
  final String lable;
  final Color? color;
  final double? width;
  final double? height;
  final String? icon;
  final bool loading;

  CHIOutlinedButton({
    this.onTap,
    required this.icon,
    required this.lable,
    this.color,
    this.disabled = false,
    this.loading = false,
    this.width,
    this.height,
    super.key,
  }) {
    child = loading
        ? ButtonLoader(primaryColor)
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon!,
                color: CHIStyles.secondryColor,
                fit: BoxFit.scaleDown,
              ),
              const SizedBox(width: 8),
              Text(
                lable,
                style: CHIStyles.mdMediumStyle.copyWith(color: primaryColor),
                textAlign: TextAlign.center,
              ),
            ],
          );
  }

  CHIOutlinedButton.colored({
    this.onTap,
    this.icon,
    required this.lable,
    this.color,
    this.disabled = false,
    this.loading = false,
    this.width,
    this.height,
    super.key,
  }) {
    primaryColor = CHIStyles.primaryColor;
    lightColor = Colors.transparent;
    child = loading
        ? ButtonLoader(primaryColor)
        : Text(
            lable,
            style: CHIStyles.mdMediumStyle.copyWith(
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          );
  }
  Color primaryColor = CHIStyles.secondryColor;
  Color lightColor = Colors.transparent;
  late Widget child;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        // shape: const StadiumBorder(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(width: 1, color: color ?? primaryColor),
        fixedSize: const Size(double.infinity, 48),
        maximumSize: const Size(double.infinity, 48),
        minimumSize: const Size(double.infinity, 48),
        backgroundColor: lightColor,
      ),
      onPressed: disabled || loading ? null : onTap,
      child: child,
    );
  }
}
