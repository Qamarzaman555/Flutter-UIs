part of '../../local_pub.dart';

// ignore: must_be_immutable
class CHIDataTable<T> extends StatelessWidget {
  final DataObject dataList;
  final List<Map<String, dynamic>> columns;
  final double rowHeight;
  final String title;
  final Widget? suffix;
  final bool fitToScreen;
  final void Function(int?)? onRowsPageChanged;
  final List<int> availableRowsPerPage;
  final int totalRecords;
  final int page;
  final void Function(int)? onPageChanged;
  final void Function(String, String?)? onSort;
  final List<Widget>? actions;
  final double headerRowHeight;
  final bool search;
  final void Function(String?)? onSearch;
  final void Function()? onReload;
  final void Function()? onAddItem;
  final bool isBusy;
  final double defaultColumnWidth;
  final ColumnWidthMode columnWidthMode;
  final ColumnWidthCalculationRange columnWidthCalculationRange;
  final ColumnSizer? columnSizer;
  final GridLinesVisibility gridLinesVisibility;
  final GridLinesVisibility headerGridLinesVisibility;
  final QueryRowHeightCallback? onQueryRowHeight;
  final SelectionMode selectionMode;
  final SelectionChangedCallback? onSelectionChanged;
  final SelectionChangingCallback? onSelectionChanging;
  final SelectionManagerBase? selectionManager;
  final DataGridController? controller;
  final GridNavigationMode navigationMode;
  final CurrentCellActivatedCallback? onCurrentCellActivated;
  final CurrentCellActivatingCallback? onCurrentCellActivating;
  final void Function(int?, int?)? onItemSelect;
  final DataGridCellDoubleTapCallback? onCellDoubleTap;
  final DataGridCellTapCallback? onCellSecondaryTap;
  final DataGridCellLongPressCallback? onCellLongPress;
  final int frozenColumnsCount;
  final int footerFrozenColumnsCount;
  final int frozenRowsCount;
  final int footerFrozenRowsCount;
  final bool allowSorting;
  // final bool allowMultiColumnSorting;
  // final bool allowTriStateSorting;
  // final bool showSortNumbers;
  // final SortingGestureType sortingGestureType;
  final List<StackedHeaderRow> stackedHeaderRows;
  final bool isScrollbarAlwaysShown;
  final ScrollPhysics horizontalScrollPhysics;
  final ScrollPhysics verticalScrollPhysics;
  final LoadMoreViewBuilder? loadMoreViewBuilder;
  final bool allowPullToRefresh;
  final double refreshIndicatorDisplacement;
  final double refreshIndicatorStrokeWidth;
  final bool allowSwiping;
  final double swipeMaxOffset;
  final ScrollController? horizontalScrollController;
  final ScrollController? verticalScrollController;
  final DataGridSwipeStartCallback? onSwipeStart;
  final DataGridSwipeUpdateCallback? onSwipeUpdate;
  final DataGridSwipeEndCallback? onSwipeEnd;
  final DataGridSwipeActionsBuilder? startSwipeActionsBuilder;
  final DataGridSwipeActionsBuilder? endSwipeActionsBuilder;
  final bool highlightRowOnHover;
  final bool allowColumnsResizing;
  final ColumnResizeMode columnResizeMode;
  final ColumnResizeStartCallback? onColumnResizeStart;
  final ColumnResizeUpdateCallback? onColumnResizeUpdate;
  final ColumnResizeEndCallback? onColumnResizeEnd;
  final bool allowEditing;
  final EditingGestureType editingGestureType;
  final Widget? footer;
  final double footerHeight;
  // final bool showCheckboxColumn;
  final bool shrinkWrapColumns;
  final bool shrinkWrapRows;
  final DataGridCheckboxColumnSettings checkboxColumnSettings;
  final List<GridTableSummaryRow> tableSummaryRows;
  final int rowsPerPage;
  final int? rowsCacheExtent;
  final bool allowFiltering;
  // final DataGridFilterChangingCallback? onFilterChanging;
  // final DataGridFilterChangedCallback? onFilterChanged;
  final OutlinedBorder? checkboxShape;
  final bool showHorizontalScrollbar;
  final bool showVerticalScrollbar;
  @Deprecated('use SfDataGrid.showColumnHeaderIconOnHover instead')
  // final bool showFilterIconOnHover;
  final bool allowColumnsDragging;
  final DataGridColumnDraggingCallback? onColumnDragging;
  final ColumnDragFeedbackBuilderCallback? columnDragFeedbackBuilder;
  final bool showColumnHeaderIconOnHover;

  CHIDataTable({
    // required this.source,
    // required this.columns,
    super.key,
    required this.dataList,
    required this.columns,
    required this.title,
    this.availableRowsPerPage = const [10, 30, 50],
    this.onRowsPageChanged,
    this.suffix,
    required this.page,
    this.fitToScreen = false,
    this.onPageChanged,
    this.onSort,
    required this.totalRecords,
    this.actions,
    this.search = true,
    this.onSearch,
    this.onAddItem,
    this.onReload,
    this.rowHeight = double.nan,
    this.isBusy = false,
    this.headerRowHeight = double.nan,
    this.defaultColumnWidth = double.nan,
    this.gridLinesVisibility = GridLinesVisibility.horizontal,
    this.headerGridLinesVisibility = GridLinesVisibility.horizontal,
    this.columnWidthMode = ColumnWidthMode.none,
    this.columnSizer,
    this.columnWidthCalculationRange = ColumnWidthCalculationRange.visibleRows,
    this.selectionMode = SelectionMode.none,
    this.navigationMode = GridNavigationMode.row,
    this.frozenColumnsCount = 0,
    this.footerFrozenColumnsCount = 0,
    this.frozenRowsCount = 0,
    this.footerFrozenRowsCount = 0,
    this.allowSorting = false,
    // this.allowMultiColumnSorting = false,
    // this.allowTriStateSorting = false,
    // this.showSortNumbers = false,
    // this.sortingGestureType = SortingGestureType.tap,
    this.stackedHeaderRows = const <StackedHeaderRow>[],
    this.selectionManager,
    this.controller,
    this.onQueryRowHeight,
    this.onSelectionChanged,
    this.onSelectionChanging,
    this.onCurrentCellActivating,
    this.onCurrentCellActivated,
    this.onItemSelect,
    this.onCellDoubleTap,
    this.onCellSecondaryTap,
    this.onCellLongPress,
    this.isScrollbarAlwaysShown = false,
    this.horizontalScrollPhysics = const AlwaysScrollableScrollPhysics(),
    this.verticalScrollPhysics = const AlwaysScrollableScrollPhysics(),
    this.loadMoreViewBuilder,
    this.allowPullToRefresh = false,
    this.refreshIndicatorDisplacement = 40.0,
    this.refreshIndicatorStrokeWidth = 2.0,
    this.allowSwiping = false,
    this.swipeMaxOffset = 200.0,
    this.horizontalScrollController,
    this.verticalScrollController,
    this.onSwipeStart,
    this.onSwipeUpdate,
    this.onSwipeEnd,
    this.startSwipeActionsBuilder,
    this.endSwipeActionsBuilder,
    this.highlightRowOnHover = true,
    this.allowColumnsResizing = false,
    this.columnResizeMode = ColumnResizeMode.onResize,
    this.onColumnResizeStart,
    this.onColumnResizeUpdate,
    this.onColumnResizeEnd,
    this.allowEditing = false,
    this.editingGestureType = EditingGestureType.doubleTap,
    this.footer,
    this.footerHeight = 49.0,
    // this.showCheckboxColumn = false,
    this.checkboxColumnSettings = const DataGridCheckboxColumnSettings(),
    this.tableSummaryRows = const <GridTableSummaryRow>[],
    required this.rowsPerPage,
    this.shrinkWrapColumns = false,
    this.shrinkWrapRows = false,
    this.rowsCacheExtent,
    this.allowFiltering = false,
    // this.onFilterChanging,
    // this.onFilterChanged,
    this.checkboxShape,
    this.showHorizontalScrollbar = true,
    this.showVerticalScrollbar = true,
    @Deprecated('use SfDataGrid.showColumnHeaderIconOnHover instead')
    // this.showFilterIconOnHover = false,
    this.allowColumnsDragging = false,
    this.onColumnDragging,
    this.columnDragFeedbackBuilder,
    this.showColumnHeaderIconOnHover = false,
  })  : assert(frozenColumnsCount >= 0),
        assert(footerFrozenColumnsCount >= 0),
        assert(frozenRowsCount >= 0),
        assert(footerFrozenRowsCount >= 0);

  int? selectedIndex;
  int? deselectedIndex;
  bool isSelected = false;

  static final stream = StreamController<bool>.broadcast();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableHeader(
          suffix: suffix,
          title: title,
          actions: actions,
          search: search,
          onSearch: onSearch,
          onAddItem: onAddItem,
          onReload: onReload,
        ),
        CHIProgressIndicator(isBusy),
        if (!isBusy) 4.spaceY,
        Expanded(
          child: SfDataGrid(
            source: CHIDataSource(context, dataList: dataList),
            columns: getColumns(context),
            rowHeight: rowHeight,
            headerRowHeight: headerRowHeight,
            defaultColumnWidth: defaultColumnWidth,
            gridLinesVisibility: gridLinesVisibility,
            headerGridLinesVisibility: headerGridLinesVisibility,
            columnWidthMode:
                fitToScreen ? ColumnWidthMode.fill : columnWidthMode,
            columnSizer: columnSizer,
            columnWidthCalculationRange: columnWidthCalculationRange,
            selectionMode: selectionMode,
            navigationMode: navigationMode,
            frozenColumnsCount: frozenColumnsCount,
            footerFrozenColumnsCount: footerFrozenColumnsCount,
            frozenRowsCount: frozenRowsCount,
            footerFrozenRowsCount: footerFrozenRowsCount,
            allowSorting: allowSorting,
            // allowMultiColumnSorting: allowMultiColumnSorting,
            // allowTriStateSorting: allowTriStateSorting,
            // showSortNumbers: showSortNumbers,
            // sortingGestureType: sortingGestureType,
            stackedHeaderRows: stackedHeaderRows,
            selectionManager: selectionManager,
            controller: controller,
            onQueryRowHeight: onQueryRowHeight,
            onSelectionChanging: onSelectionChanging,
            onCurrentCellActivating: onCurrentCellActivating,
            onCurrentCellActivated: onCurrentCellActivated,
            onCellTap: onItemSelect == null
                ? null
                : (details) {
                    final index = details.rowColumnIndex.rowIndex - 1;
                    if (index != -1) onSelect(index);
                    stream.sink.add(selectedIndex != null);
                    onItemSelect!(selectedIndex, deselectedIndex);
                  },

            onCellDoubleTap: onCellDoubleTap,
            onCellSecondaryTap: onCellSecondaryTap,
            onCellLongPress: onCellLongPress,
            isScrollbarAlwaysShown: isScrollbarAlwaysShown,
            horizontalScrollPhysics: horizontalScrollPhysics,
            verticalScrollPhysics: verticalScrollPhysics,
            loadMoreViewBuilder: loadMoreViewBuilder,
            allowPullToRefresh: allowPullToRefresh,
            refreshIndicatorDisplacement: refreshIndicatorDisplacement,
            refreshIndicatorStrokeWidth: refreshIndicatorStrokeWidth,
            allowSwiping: allowSwiping,
            swipeMaxOffset: swipeMaxOffset,
            horizontalScrollController: horizontalScrollController,
            verticalScrollController: verticalScrollController,
            onSwipeStart: onSwipeStart,
            onSwipeUpdate: onSwipeUpdate,
            onSwipeEnd: onSwipeEnd,
            startSwipeActionsBuilder: startSwipeActionsBuilder,
            endSwipeActionsBuilder: endSwipeActionsBuilder,
            highlightRowOnHover: highlightRowOnHover,
            allowColumnsResizing: allowColumnsResizing,
            columnResizeMode: columnResizeMode,
            onColumnResizeStart: onColumnResizeStart,
            onColumnResizeUpdate: onColumnResizeUpdate,
            onColumnResizeEnd: onColumnResizeEnd,
            allowEditing: allowEditing,
            editingGestureType: editingGestureType,
            footer: footer,
            footerHeight: footerHeight,
            showCheckboxColumn: onItemSelect != null,
            checkboxColumnSettings: checkboxColumnSettings,
            tableSummaryRows: tableSummaryRows,
            rowsPerPage: rowsPerPage,
            shrinkWrapColumns: shrinkWrapColumns,
            shrinkWrapRows: shrinkWrapRows,
            rowsCacheExtent: rowsCacheExtent,
            // allowFiltering: allowFiltering,
            // onFilterChanging: onFilterChanging,
            // onFilterChanged: onFilterChanged,
            checkboxShape: checkboxShape,
            showHorizontalScrollbar: showHorizontalScrollbar,
            showVerticalScrollbar: showVerticalScrollbar,
            // showFilterIconOnHover: showFilterIconOnHover,
            allowColumnsDragging: allowColumnsDragging,
            onColumnDragging: onColumnDragging,
            columnDragFeedbackBuilder: columnDragFeedbackBuilder,
            showColumnHeaderIconOnHover: showColumnHeaderIconOnHover,
          ),
        ),
        Paginator(
          rowsPerPage: rowsPerPage,
          availableRowsPerPage: availableRowsPerPage,
          onRowsPageChanged: onRowsPageChanged,
          page: page,
          totalRecords: totalRecords,
          onPageChanged: onPageChanged,
        ),
      ],
    );
  }

  List<GridColumn> getColumns(BuildContext context) {
    final List<GridColumn> tempColumns = [];
    for (final column in columns) {
      tempColumns.add(_gridColumn(context, column));
    }
    return tempColumns;
  }

  int? onSelect(int index) {
    deselectedIndex = selectedIndex ?? deselectedIndex;
    if (index == selectedIndex) {
      selectedIndex = null;
    } else {
      selectedIndex = index;
    }
    return selectedIndex;
  }

  GridColumn _gridColumn(BuildContext context, Map<String, dynamic> column) {
    return GridColumn(
        columnName: column['columnName'],
        // allowSorting: false, //column['sort'],
        // allowFiltering: false, //column['filter'],
        width: fitToScreen ? double.nan : 180,
        label: Container(
          padding: const EdgeInsets.only(left: 8),
          color: context.isDark
              ? context.appTheme
                  .extension<CHITheme>()!
                  .cardColor!
                  .withOpacity(0.5)
              : Colors.grey[300],
          child: Row(
            children: [
              Flexible(
                child: Text(
                  column['columnName'],
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              if (column['sort'] ?? false)
                _SortingHandler(column: column, onSort: onSort),
              // if (column['filter'] != null && )
              //   _SortingHandler(column: column, onSort: onSort),
              _FilteringHandler(column['filter']),
            ],
          ),
        ));
  }
}

typedef SelectionChangedCallback = void Function(
    List<DataGridRow> addedRows, List<DataGridRow> removedRows);
typedef DataObject = List<List<Map<String, dynamic>>>;

typedef ToMap = DataObject Function();

class _SortingHandler extends StatefulWidget {
  final Map<String, dynamic> column;
  final void Function(String, String?)? onSort;
  const _SortingHandler({required this.column, this.onSort});

  @override
  State<_SortingHandler> createState() => __SortingHandlerState();
}

class __SortingHandlerState extends State<_SortingHandler> {
  String? order;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: widget.onSort == null
            ? null
            : () {
                if (order == null) {
                  order = 'ASC';
                } else if (order == 'ASC') {
                  order = 'DESC';
                } else {
                  order = null;
                }
                widget.onSort!(widget.column['key'], order);
                setState(() {});
              },
        icon: Icon(
          _icon(order),
          color: Colors.grey,
          size: 16,
        ));
  }
}

IconData _icon(String? order) {
  if (order == 'ASC') return Icons.arrow_upward;
  if (order == 'DESC') return Icons.arrow_downward;
  return Icons.swap_vert;
}

class _FilteringHandler extends StatelessWidget {
  final Map<String, dynamic>? filter;
  const _FilteringHandler(this.filter);

  @override
  Widget build(BuildContext context) {
    if (filter != null) {
      return IconButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              child: Column(
                children: filter!['data']
                    .map((data) =>
                        ListTile(title: Text('${data['displayName']}')))
                    .toList()
                    .cast<Widget>(),
              ),
            );
          },
        ),
        icon: const Icon(
          Icons.filter_alt_outlined,
          color: Colors.grey,
          size: 16,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
