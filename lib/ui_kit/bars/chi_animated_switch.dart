part of '../local_pub.dart';

class CHIAnimatedSwitch extends StatelessWidget {
  final bool value;
  final VoidCallback? onSwitch;

  /// A simple animated switch (toggle button) customized on CHI design pattern.
  const CHIAnimatedSwitch({super.key, required this.value, this.onSwitch});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSwitch,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        height: 14,
        width: 22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
        ),
        child: Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Theme.of(context).primaryColor, width: 2),
          ),
        ),
      ),
    );
  }
}
