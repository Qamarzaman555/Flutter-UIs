import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

class Paginator extends StatelessWidget {
  const Paginator({
    super.key,
    required this.rowsPerPage,
    required this.availableRowsPerPage,
    required this.onRowsPageChanged,
    required this.page,
    required this.totalRecords,
    required this.onPageChanged,
  });

  final int rowsPerPage;
  final List<int> availableRowsPerPage;
  final void Function(int?)? onRowsPageChanged;
  final int page;
  final int totalRecords;
  final void Function(int)? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text('items per page:'),
        16.spaceX,
        DropdownButton(
          elevation: 0,
          focusColor: Colors.transparent,
          hint: Text('$rowsPerPage'),
          underline: const SizedBox(),
          items: availableRowsPerPage
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text('$item'),
                  ))
              .toList(),
          onChanged: (value) {
            if (onRowsPageChanged != null) {
              onRowsPageChanged!(value);
            }
          },
        ),
        12.spaceX,
        Text(
            '${((rowsPerPage * page) - rowsPerPage) + 1} - ${rowsPerPage * page >= totalRecords ? totalRecords : rowsPerPage * page} of $totalRecords'),
        16.spaceX,
        IconButton(
            onPressed: page < 2
                ? null
                : () {
                    if (onPageChanged != null) {
                      onPageChanged!(1);
                    }
                  },
            icon: const Icon(
              Icons.first_page,
            )),
        IconButton(
            onPressed: page < 2
                ? null
                : () {
                    if (onPageChanged != null) {
                      final decPage = page - 1;
                      onPageChanged!(decPage);
                    }
                  },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            )),
        IconButton(
            onPressed: rowsPerPage * page >= totalRecords
                ? null
                : () {
                    if (onPageChanged != null) {
                      final incPage = page + 1;
                      onPageChanged!(incPage);
                    }
                  },
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            )),
        IconButton(
            onPressed: rowsPerPage * page >= totalRecords
                ? null
                : () {
                    if (onPageChanged != null) {
                      final lastPage = (totalRecords / rowsPerPage).ceil();
                      onPageChanged!(lastPage);
                    }
                  },
            icon: const Icon(Icons.last_page)),
      ],
    );
  }
}
