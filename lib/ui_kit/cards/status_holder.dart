part of '../local_pub.dart';

class StatusHolder extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onTap;

  const StatusHolder({
    super.key,
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: CHIStyles.xsMediumStyle.copyWith(color: foregroundColor),
        ),
      ),
    );
  }
}
