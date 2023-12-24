part of '../local_pub.dart';

class CHIAddressField extends CHITextField {
  const CHIAddressField({
    super.key,
    super.controller,
    super.prefixIcon,
    super.mandatory = false,
    super.hintText,
    super.enableBorder,
    super.fillColor,
    super.onSaved,
    super.onEditingComplete,
    super.validator,
    super.initialValue,
    super.suffixIcon,
    super.heading = '',
    super.onFieldSubmitted,
    super.onChanged,
    super.minLine = null,
  });

  @override
  Widget build(BuildContext context) {
    return CHITextField(
      controller: controller,
      prefixIcon: prefixIcon,
      mandatory: mandatory,
      hintText: hintText,
      enableBorder: enableBorder,
      fillColor: fillColor,
      onSaved: onSaved,
      onEditingComplete: onEditingComplete,
      validator: validator,
      initialValue: initialValue,
      suffixIcon: suffixIcon,
      heading: heading,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      keyboardType: TextInputType.text,
      minLine: minLine ?? 4,
      maxLine: 10,
    );
  }
}
