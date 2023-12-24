part of '../local_pub.dart';

class CHIEmailField extends CHITextField {
  const CHIEmailField({
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
    super.keyboardType,
    super.inputFormat,
  });

  @override
  Widget build(BuildContext context) {
    final emailInputFormatter =
        FilteringTextInputFormatter.deny(RegExp('[^a-zA-Z0-9@.]'));
    return CHITextField(
      controller: controller,
      prefixIcon: prefixIcon,
      mandatory: mandatory,
      hintText: hintText,
      onSaved: onSaved,
      fillColor: fillColor,
      enableBorder: enableBorder,
      onEditingComplete: onEditingComplete,
      validator: validator,
      initialValue: initialValue,
      suffixIcon: suffixIcon,
      heading: heading,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      keyboardType: TextInputType.emailAddress,
      inputFormat: [emailInputFormatter],
    );
  }
}
