import 'package:flutter/material.dart';

class QamarTerxtField extends StatefulWidget {
  final bool isPasswordField;
  const QamarTerxtField({
    this.isPasswordField = false,
    super.key,
  });

  @override
  State<QamarTerxtField> createState() => _QamarTerxtFieldState();
}

class _QamarTerxtFieldState extends State<QamarTerxtField> {
  bool obsecured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        hintText: widget.isPasswordField ? 'Write password' : 'Write text...',
        fillColor: Colors.grey.shade200,
        filled: true,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.white),
        ),
        suffixIcon: widget.isPasswordField
            ? GestureDetector(
                onTap: () {
                  onChangeVisibility();
                },
                child:
                    Icon(obsecured ? Icons.visibility : Icons.visibility_off),
              )
            : null,
      ),
      obscureText: widget.isPasswordField ? obsecured : false,
      textAlignVertical: TextAlignVertical.center,
    );
  }

  onChangeVisibility() {
    obsecured = !obsecured;
    setState(() {});
  }
}
