part of '../local_pub.dart';

class ToggleButton extends StatelessWidget {
  final List<Widget> widgets;
  final void Function(int) onPressed;
  final List<bool> values;
  const ToggleButton({
    super.key,
    required this.widgets,
    required this.onPressed,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: values,
      onPressed: onPressed,
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      selectedBorderColor: Colors.blue[700],
      selectedColor: CHIStyles.whiteColor,
      fillColor: Theme.of(context).extension<CHITheme>()?.primaryColor,
      constraints: const BoxConstraints(
        minHeight: 45.0,
        minWidth: 120.0,
      ),
      children: widgets,
    );
  }
}
