import 'package:flutter/material.dart';

class QamarAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Widget? textfieldWidget;
  final bool textfield;
  const QamarAppBar({
    super.key,
    required this.title,
    this.textfieldWidget,
    this.textfield = false,
  });

  @override
  State<QamarAppBar> createState() => _QamarAppBarState();

  @override
  Size get preferredSize => const Size(64, 64);
}

class _QamarAppBarState extends State<QamarAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: widget.textfield
          ? widget.textfieldWidget ?? const SizedBox()
          : Container(
              color: Colors.black38,
              child: Row(
                children: [
                  Text(widget.title),
                ],
              )),
      // title: Text(widget.title),
    );
  }
}
