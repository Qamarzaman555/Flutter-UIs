part of '../local_pub.dart';

class CHICheckBox extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;

  const CHICheckBox({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      width: 16,
      child: _themeBox(context, value, onChanged),
    );
  }
}

Theme _themeBox(
    BuildContext context, bool value, void Function(bool?)? onChanged) {
  return Theme(
    data: ThemeData(unselectedWidgetColor: Colors.grey),
    child: Checkbox(
      activeColor: Theme.of(context).extension<CHITheme>()?.primaryColor,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xff98A2B3)),
        borderRadius: BorderRadius.circular(4),
      ),
      value: value,
      onChanged: onChanged,
    ),
  );
}


