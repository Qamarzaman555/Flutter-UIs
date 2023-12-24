import 'package:flutter/material.dart';

class QamarElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData? icon;
  const QamarElevatedButton({
    this.onPressed,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const Text(
              'ELEVATED BUTTON',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ));
  }
}
