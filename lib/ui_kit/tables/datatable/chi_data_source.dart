part of '../../local_pub.dart';

class CHIDataSource<T> extends DataGridSource {
  final BuildContext context;
  final List<DataGridRow> _dataList = [];
  final editingController = TextEditingController();
  final DataObject dataList;

  CHIDataSource(this.context, {required this.dataList}) {
    for (final data in dataList) {
      final List<DataGridCell> cells = [];

      for (final column in data) {
        cells.add(
          DataGridCell(
            columnName: column['columnName'],
            value: column['value'],
          ),
        );
      }

      _dataList.add(DataGridRow(cells: cells));
    }
  }

  @override
  List<DataGridRow> get rows => _dataList;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final index = _dataList.indexOf(row);
    return DataGridRowAdapter(
        color: index % 2 == 0
            ? Colors.transparent
            : context.isDark
                ? context.appTheme
                    .extension<CHITheme>()!
                    .cardColor!
                    .withOpacity(0.5)
                : Colors.grey[300],
        cells: row.getCells().map<Widget>((cell) {
          if (cell.value is Widget) return cell.value;
          return Padding(
            padding: const EdgeInsets.only(top: 18, left: 8),
            child: Text(
              '${cell.value ?? ''}',
              textAlign: TextAlign.justify,
            ),
          );
        }).toList());
  }
}
