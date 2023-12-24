import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

class TableLoader extends StatelessWidget {
  const TableLoader({
    super.key,
    required this.isBusy,
  });

  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isBusy,
      child: Container(
        color: context.isDark
            ? Colors.grey.withOpacity(0.05)
            : Colors.grey.withOpacity(0.1),
        child: CHIProgressIndicator(isBusy, loaderType: LoaderType.circular),
      ),
    );
  }
}
