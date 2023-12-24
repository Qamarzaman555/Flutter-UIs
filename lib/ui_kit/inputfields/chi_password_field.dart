part of '../local_pub.dart';

class CHIPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final bool mandatory;
  final String? hintText;
  final bool enableBorder;
  final Color? fillColor;
  final Function(String?)? onSaved;
  final VoidCallback? onEditingComplete;
  final String? Function(String?)? validator;
  final String? initialValue;
  final String? heading;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onChanged;
  const CHIPasswordField({
    super.key,
    this.controller,
    this.prefixIcon,
    this.mandatory = false,
    this.hintText,
    this.onSaved,
    this.fillColor,
    this.enableBorder = false,
    this.onEditingComplete,
    this.validator,
    this.initialValue,
    this.heading,
    this.onFieldSubmitted,
    this.onChanged,
  });

  @override
  State<CHIPasswordField> createState() => _CHIPasswordFieldState();
}

class _CHIPasswordFieldState extends State<CHIPasswordField> {
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return CHITextField(
      textAlignVertical: TextAlignVertical.center,
      controller: widget.controller,
      prefixIcon: widget.prefixIcon,
      mandatory: widget.mandatory,
      hintText: widget.hintText,
      onSaved: widget.onSaved,
      fillColor: widget.fillColor,
      enableBorder: widget.enableBorder,
      onEditingComplete: widget.onEditingComplete,
      validator: widget.validator,
      initialValue: widget.initialValue,
      suffixIcon: IconButton(
          onPressed: () => setState(() => visible = !visible),
          icon: Icon(
            visible ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          )),
      heading: widget.heading,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      obscureText: visible,
    );
  }
}
