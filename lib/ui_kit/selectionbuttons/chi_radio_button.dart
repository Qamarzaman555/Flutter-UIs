part of '../local_pub.dart';

class CHIRadioButton extends StatelessWidget {
  final Object value;
  final Object? groupValue;
  final void Function(Object?)? onChanged;

  const CHIRadioButton({
    super.key,
    required this.value,
    this.groupValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Radio(
      value: value,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      groupValue: groupValue,
      onChanged: onChanged,
      fillColor: MaterialStateProperty.all(
        Theme.of(context).extension<CHITheme>()?.primaryColor,
      ),
      focusColor: Colors.grey,
    );
  }
}
