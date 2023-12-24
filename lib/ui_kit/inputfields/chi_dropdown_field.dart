part of '../local_pub.dart';

class CHIDropdownTextField extends StatelessWidget {
  const CHIDropdownTextField(
      {required this.label,
      required this.dropDownItems,
      required this.onChanged,
      this.validator,
      this.borderRadius = 8,
      this.enableSearch = false,
      this.labelColor = Colors.grey,
      this.fillColor,
      super.key});
  final String label;
  final List<String> dropDownItems;
  final void Function(String v) onChanged;
  final String? Function(String?)? validator;
  final double borderRadius;
  final bool enableSearch;
  final Color labelColor;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      listPadding: ListPadding(top: 4, bottom: 4),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enableSearch: enableSearch,
      validator: validator,
      textFieldDecoration: InputDecoration(
        labelText: label,
        labelStyle:
            MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
          Color? color = states.contains(MaterialState.error)
              ? CHIStyles.primaryErrorColor
              : labelColor;
          return TextStyle(
            color: color,
          );
        }),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: fillColor != null,
        fillColor: fillColor,
        focusedBorder: _fieldBorder(
            color: Theme.of(context).extension<CHITheme>()?.secondryColor,
            borderRadius: borderRadius),
        enabledBorder: _fieldBorderEnabled(),
        disabledBorder: _fieldBorder(borderRadius: borderRadius),
        errorBorder: _fieldBorder(
            color: CHIStyles.primaryErrorColor, borderRadius: borderRadius),
        focusedErrorBorder: _fieldBorder(
            color: CHIStyles.primaryErrorColor, borderRadius: borderRadius),
      ),
      dropDownList: dropDownItems
          .map((e) => DropDownValueModel(name: e, value: e))
          .toList(),
      onChanged: (v) {
        String value = v.value;
        onChanged(value);
      },
      dropdownColor: Theme.of(context).extension<CHITheme>()?.cardColor,
      dropDownIconProperty: IconProperty(
          color: Theme.of(context).extension<CHITheme>()?.actionButtonColor,
          icon: Icons.keyboard_arrow_down),
    );
  }
}

OutlineInputBorder _fieldBorder({Color? color, double? borderRadius}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius ?? 6),
    borderSide: BorderSide(color: color ?? Colors.grey, width: 2),
  );
}

OutlineInputBorder _fieldBorderEnabled({double? borderRadius}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius ?? 6),
    borderSide: const BorderSide(color: Colors.transparent, width: 2),
  );
}
