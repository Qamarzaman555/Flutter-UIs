part of '../local_pub.dart';

class CHIResponsiveView extends StatelessWidget {
  final Widget mobile;
  final Widget webSmall;
  final Widget medium;
  final Widget large;
  const CHIResponsiveView({
    super.key,
    required this.mobile,
    required this.webSmall,
    required this.medium,
    required this.large,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (!kIsWeb && context.kShortestSide < 550) return mobile;
      if (constraints.maxWidth < 800) return webSmall;
      if (constraints.maxWidth <= 1100) return medium;
      return large;
    });
  }
}
