part of '../local_pub.dart';

class CHIIntegerField extends CHITextField {
  const CHIIntegerField({
    super.key,
    super.controller,
    super.prefixIcon,
    super.mandatory,
    super.hintText,
    super.onSaved,
    super.enableBorder,
    super.fillColor,
    super.onEditingComplete,
    super.validator,
    super.initialValue,
    super.suffixIcon,
    super.heading,
    super.onFieldSubmitted,
    super.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final numericInputFormatter =
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
    return CHITextField(
      controller: controller,
      prefixIcon: prefixIcon,
      mandatory: mandatory,
      hintText: hintText,
      onSaved: onSaved,
      enableBorder: enableBorder,
      fillColor: fillColor,
      onEditingComplete: onEditingComplete,
      validator: validator,
      initialValue: initialValue,
      suffixIcon: suffixIcon,
      heading: heading,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      inputFormat: [numericInputFormatter],
    );
  }
}
