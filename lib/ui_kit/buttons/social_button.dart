part of '../local_pub.dart';

class SocialButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final double? height;
  final double? width;
  const SocialButton({
    required this.icon,
    this.height,
    this.width,
    this.padding,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: height ?? 52,
        width: width,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: SvgPicture.asset(
          'assets/icons/$icon.svg',
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
