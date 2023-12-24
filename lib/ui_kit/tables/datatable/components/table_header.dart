import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:practice/ui_kit/buttons/action_button.dart';
import 'package:practice/ui_kit/local_pub.dart';

class TableHeader extends StatefulWidget {
  final Widget? suffix;
  final String title;
  final List<Widget>? actions;
  final bool search;
  final void Function(String?)? onSearch;
  final void Function()? onReload;
  final void Function()? onAddItem;

  const TableHeader({
    super.key,
    required this.suffix,
    required this.title,
    required this.actions,
    this.search = true,
    this.onSearch,
    this.onAddItem,
    this.onReload,
  });

  @override
  State<TableHeader> createState() => _TableHeaderState();
}

class _TableHeaderState extends State<TableHeader> {
  Timer? timer;
  bool isSelected = false;

  late StreamSubscription _subscription;

  @override
  initState() {
    super.initState();
    _subscription = CHIDataTable.stream.stream.listen((isSelected) {
      setState(() {
        this.isSelected = isSelected;
      });
    });
  }

  @override
  dispose() {
    _subscription.cancel();
    CHIDataTable.stream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CHICard(
      child: Row(
        children: [
          if (widget.suffix != null)
            Padding(
              padding: context.locale == const Locale('ar', 'SA')
                  ? const EdgeInsets.only(left: 8)
                  : const EdgeInsets.only(right: 8),
              child: widget.suffix,
            ),
          Text(widget.title, style: CHIStyles.lgBoldStyle),
          16.spaceX,
          if (widget.search)
            SizedBox(
              width: context.kWidth / 4,
              child: CHITextField(
                hintText: 'Search',
                enableBorder: true,
                suffixIcon:
                    const Icon(Icons.search_outlined, color: Colors.grey),
                onChanged: (query) {
                  timer?.cancel();
                  timer = Timer(const Duration(seconds: 1), () {
                    if (widget.onSearch != null) {
                      widget.onSearch!(query);
                    }
                  });
                },
              ),
            ),
          const Spacer(),
          if (isSelected) ...widget.actions ?? [],
          12.spaceX,
          CHIActionButton(
            onTap: widget.onAddItem,
            child: const Icon(Icons.add),
          ),
          12.spaceX,
          CHIActionButton(
            onTap: widget.onReload,
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
