part of '../local_pub.dart';

class CHITextField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final bool autoFocus;
  final bool mandatory;
  final String? heading;
  final List<TextInputFormatter>? inputFormat;
  final String? hintText;
  final String? labelText;
  final Color? labelColor;
  final bool enableBorder;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLine;
  final int? minLine;
  final Color? fillColor;
  final FocusNode? focusNode;
  final Function(String?)? onSaved;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool enableInteractiveSelection;
  final bool obscureText;
  final double? borderRadius;
  final Widget? suffixIcon;
  final Color? focusedBorderColor;
  final void Function(String)? onFieldSubmitted;
  final AutovalidateMode? autovalidateMode;
  final TextAlignVertical? textAlignVertical;
  final void Function(String?)? onChanged;
  final EdgeInsetsGeometry contentPadding;
  const CHITextField({
    this.controller,
    this.hintText,
    this.labelText,
    this.labelColor,
    this.prefixIcon,
    this.inputFormat,
    this.heading,
    this.enableBorder = false,
    this.autoFocus = false,
    this.mandatory = false,
    this.keyboardType,
    this.borderRadius,
    this.maxLength,
    this.maxLine = 1,
    this.minLine = 1,
    this.focusNode,
    this.enableInteractiveSelection = true,
    this.onSaved,
    this.fillColor,
    this.onEditingComplete,
    this.textInputAction,
    this.focusedBorderColor,
    this.onFieldSubmitted,
    this.validator,
    this.initialValue,
    this.suffixIcon,
    this.obscureText = false,
    this.textAlignVertical,
    this.onChanged,
    this.autovalidateMode,
    this.contentPadding = const EdgeInsets.all(16),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: heading != null,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text.rich(
              TextSpan(
                text: "$heading",
                style: CHIStyles.smNormalStyle,
                children: mandatory
                    ? [
                        TextSpan(
                          text: "*",
                          style: CHIStyles.smNormalStyle
                              .copyWith(color: CHIStyles.primaryErrorColor),
                        )
                      ]
                    : null,
              ),
            ),
          ),
        ),
        TextFormField(
          autovalidateMode: autovalidateMode,
          textAlignVertical: textAlignVertical,
          autofocus: autoFocus,
          focusNode: focusNode,
          onSaved: onSaved,
          obscureText: obscureText,
          validator: validator,
          initialValue: initialValue,
          textInputAction: textInputAction,
          onChanged: onChanged,
          cursorColor: Theme.of(context).extension<CHITheme>()?.secondryColor,
          onFieldSubmitted: onFieldSubmitted,
          onEditingComplete: onEditingComplete,
          controller: controller,
          maxLength: maxLength,
          maxLines: maxLine,
          minLines: minLine,
          enableInteractiveSelection: enableInteractiveSelection,
          inputFormatters: inputFormat,
          style: CHIStyles.smMediumStyle,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            fillColor: fillColor,
            filled: fillColor != null,
            border: InputBorder.none,
            hintText: hintText,
            labelText: labelText,
            labelStyle:
                MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
              Color? color = states.contains(MaterialState.error)
                  ? CHIStyles.primaryErrorColor
                  : labelColor;
              return TextStyle(color: color ?? CHIStyles.primaryColor);
            }),
            suffixIcon: suffixIcon,
            floatingLabelStyle:
                MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
              Color? color = states.contains(MaterialState.error)
                  ? CHIStyles.primaryErrorColor
                  : focusedBorderColor;
              return TextStyle(color: color ?? CHIStyles.secondryColor);
            }),
            focusedBorder: _fieldBorder(
                color: focusedBorderColor ??
                    Theme.of(context).extension<CHITheme>()?.secondryColor,
                borderRadius: borderRadius),
            enabledBorder: enableBorder
                ? _fieldBorder(borderRadius: borderRadius)
                : _fieldBorderEnabled(),
            disabledBorder: _fieldBorder(borderRadius: borderRadius),
            errorBorder: _fieldBorder(
                color: CHIStyles.primaryErrorColor, borderRadius: borderRadius),
            focusedErrorBorder: _fieldBorder(
                color: CHIStyles.primaryErrorColor, borderRadius: borderRadius),
            contentPadding: contentPadding,
            hintStyle: CHIStyles.smMediumStyle.copyWith(color: Colors.grey),
            counterText: '',
          ),
        ),
      ],
    );
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
      borderSide: const BorderSide(color: Colors.transparent),
    );
  }
}
