part of '../local_pub.dart';

const _kSlideTransitionDuration = Duration(milliseconds: 300);
const _kActionHeight = 36.0;

/// Shows a dialog containing a date picker.
///
/// The returned [Future] resolves to the date selected by the user when the
/// user confirms the dialog. If the user cancels the dialog, null is returned.
///
/// When the date picker is first displayed, it will show the month of
/// [initialDate], with [initialDate] selected.
///
/// The [firstDate] is the earliest allowable date. The [lastDate] is the latest
/// allowable date. [initialDate] must either fall between these dates,
/// or be equal to one of them
///
/// The [width] define the width of date picker dialog
///
Future<DateTime?> showWebDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  double? width,
}) {
  return showPopupDialog(
    context,
    (context) => Theme(
      data: ThemeData(
        colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor),
        ),
      ),
      child: _WebDatePicker(
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(0),
        lastDate: lastDate ?? DateTime(100000),
      ),
    ),
    asDropDown: true,
    useTargetWidth: width != null ? false : true,
    dialogWidth: width,
  );
}

class _WebDatePicker extends StatefulWidget {
  const _WebDatePicker({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  @override
  State<_WebDatePicker> createState() => _WebDatePickerState();
}

class _WebDatePickerState extends State<_WebDatePicker> {
  late DateTime _selectedDate;
  late DateTime _startDate;

  double _slideDirection = 1.0;
  _PickerViewMode _viewMode = _PickerViewMode.day;
  bool _isViewModeChanged = false;
  Size? _childSize;

  @override
  void initState() {
    super.initState();
    _selectedDate = _startDate = widget.initialDate;
  }

  List<Widget> _buildDaysOfMonthCells(ThemeData theme) {
    final textStyle = theme.textTheme.bodySmall?.copyWith(color: Colors.black);
    final now = DateTime.now();
    final monthDateRange =
        _startDate.monthDateTimeRange(includeTrailingAndLeadingDates: true);
    final children = kWeekdayAbbreviations
        .map<Widget>(
          (e) => Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(e, style: textStyle),
          ),
        )
        .toList();
    for (int i = 0; i < kNumberCellsOfMonth; i++) {
      final date = monthDateRange.start.add(Duration(days: i));
      if (_startDate.month == date.month) {
        final isEnabled = (date.dateCompareTo(widget.firstDate) >= 0) &&
            (date.dateCompareTo(widget.lastDate) <= 0);
        final isSelected = date.dateCompareTo(_selectedDate) == 0;
        final isNow = date.dateCompareTo(now) == 0;
        final color = isEnabled
            ? theme.colorScheme.primary
            : theme.colorScheme.primary.withOpacity(0.5);
        Widget child = Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? color : null,
            border: isNow && !isSelected ? Border.all(color: color) : null,
          ),
          child: Text(
            date.day.toString(),
            style: isSelected
                ? textStyle?.copyWith(color: theme.colorScheme.onPrimary)
                : isEnabled
                    ? textStyle
                    : textStyle?.copyWith(color: theme.disabledColor),
          ),
        );
        if (isEnabled) {
          child = InkWell(
            onTap: () => setState(() => _selectedDate = date),
            customBorder: const CircleBorder(),
            child: child,
          );
        }
        children.add(Padding(padding: const EdgeInsets.all(2.0), child: child));
      } else {
        children.add(Container());
      }
    }
    return children;
  }

  List<Widget> _buildMonthsOfYearCells(ThemeData theme) {
    final textStyle = theme.textTheme.bodySmall?.copyWith(color: Colors.black);
    final borderRadius = BorderRadius.circular(_childSize!.height / 4 - 32);
    final children = <Widget>[];
    final now = DateTime.now();
    for (int i = 1; i <= kNumberOfMonth; i++) {
      final date = DateTime(_startDate.year, i);
      final isEnabled = (date.monthCompareTo(widget.firstDate) >= 0) &&
          (date.monthCompareTo(widget.lastDate) <= 0);
      final isSelected = date.monthCompareTo(_selectedDate) == 0;
      final isNow = date.monthCompareTo(now) == 0;
      final color = isEnabled
          ? theme.colorScheme.primary
          : theme.colorScheme.primary.withOpacity(0.5);
      Widget child = Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? color : null,
          border: isNow && !isSelected ? Border.all(color: color) : null,
          borderRadius: borderRadius,
        ),
        child: Text(
          kMonthShortNames[i - 1],
          style: isSelected
              ? textStyle?.copyWith(color: theme.colorScheme.onPrimary)
              : isEnabled
                  ? textStyle
                  : textStyle?.copyWith(color: theme.disabledColor),
        ),
      );
      if (isEnabled) {
        child = InkWell(
          onTap: () => _onViewModeChanged(next: false, date: date),
          borderRadius: borderRadius,
          child: child,
        );
      }
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: child,
        ),
      );
    }
    return children;
  }

  List<Widget> _buildYearsCells(ThemeData theme) {
    final textStyle = theme.textTheme.bodySmall?.copyWith(color: Colors.black);
    final borderRadius = BorderRadius.circular(_childSize!.height / 5 - 16);
    final children = <Widget>[];
    final now = DateTime.now();
    final year = _startDate.year - _startDate.year % 20;
    for (int i = 0; i < 20; i++) {
      final date = DateTime(year + i);
      final isEnabled = (date.year >= widget.firstDate.year) &&
          (date.year <= widget.lastDate.year);
      final isSelected = date.year == _selectedDate.year;
      final isNow = date.year == now.year;
      final color = isEnabled
          ? theme.colorScheme.primary
          : theme.colorScheme.primary.withOpacity(0.5);
      Widget child = Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? color : null,
          border: isNow && !isSelected ? Border.all(color: color) : null,
          borderRadius: borderRadius,
        ),
        child: Text(
          (year + i).toString(),
          style: isSelected
              ? textStyle?.copyWith(color: theme.colorScheme.onPrimary)
              : isEnabled
                  ? textStyle
                  : textStyle?.copyWith(color: theme.disabledColor),
        ),
      );
      if (isEnabled) {
        child = InkWell(
          onTap: () => _onViewModeChanged(next: false, date: date),
          borderRadius: borderRadius,
          child: child,
        );
      }
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: child,
        ),
      );
    }
    return children;
  }

  List<Widget> _buildYearsOfCenturyCells(ThemeData theme) {
    final textStyle = theme.textTheme.bodySmall?.copyWith(color: Colors.black);
    final borderRadius = BorderRadius.circular(_childSize!.height / 5 - 16);
    final children = <Widget>[];
    final now = DateTime.now();
    final year = _startDate.year - _startDate.year % 200;
    for (int i = 0; i < 10; i++) {
      final date = DateTime(year + i * 20);
      final isEnabled = (widget.firstDate.year <= date.year ||
              (widget.firstDate.year - date.year) <= 20) &&
          (date.year + 20 <= widget.lastDate.year ||
              (date.year - widget.lastDate.year) <= 0);
      final isSelected = _selectedDate.year >= date.year &&
          (_selectedDate.year - date.year) < 20;
      final isNow = now.year >= date.year && (now.year - date.year) < 20;
      final color = isEnabled
          ? theme.colorScheme.primary
          : theme.colorScheme.primary.withOpacity(0.5);
      Widget child = Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? color : null,
          border: isNow && !isSelected ? Border.all(color: color) : null,
          borderRadius: borderRadius,
        ),
        child: Text(
          "${date.year} - ${date.year + 19}",
          style: isSelected
              ? textStyle?.copyWith(color: theme.colorScheme.onPrimary)
              : isEnabled
                  ? textStyle
                  : textStyle?.copyWith(color: theme.disabledColor),
        ),
      );
      if (isEnabled) {
        child = InkWell(
          onTap: () => _onViewModeChanged(next: false, date: date),
          borderRadius: borderRadius,
          child: child,
        );
      }
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: child,
        ),
      );
    }
    return children;
  }

  Widget _buildChild(ThemeData theme) {
    switch (_viewMode) {
      case _PickerViewMode.day:
        return UniformGrid(
          key: _PickerKey(date: _startDate, viewMode: _viewMode),
          columnCount: kNumberOfWeekday,
          squareCell: true,
          onSizeChanged: _onSizeChanged,
          children: _buildDaysOfMonthCells(theme),
        );
      case _PickerViewMode.month:
        return UniformGrid(
          key: _PickerKey(date: _startDate, viewMode: _viewMode),
          columnCount: 3,
          withHeader: false,
          fixedSize: _childSize,
          children: _buildMonthsOfYearCells(theme),
        );
      case _PickerViewMode.year:
        return UniformGrid(
          key: _PickerKey(date: _startDate, viewMode: _viewMode),
          columnCount: 4,
          withHeader: false,
          fixedSize: _childSize,
          children: _buildYearsCells(theme),
        );
      case _PickerViewMode.century:
        return UniformGrid(
          key: _PickerKey(date: _startDate, viewMode: _viewMode),
          columnCount: 2,
          withHeader: false,
          fixedSize: _childSize,
          children: _buildYearsOfCenturyCells(theme),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget navTitle;
    bool isFirst = false, isLast = false, nextView = true;
    switch (_viewMode) {
      case _PickerViewMode.day:
        navTitle = Container(
          height: _kActionHeight,
          alignment: Alignment.center,
          child: Text(
            "${kMonthNames[_startDate.month - 1]} ${_startDate.year}",
            style: theme.textTheme.bodyLarge
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        );
        final monthDateRange = _startDate.monthDateTimeRange(
            includeTrailingAndLeadingDates: false);
        isFirst = widget.firstDate.dateCompareTo(monthDateRange.start) >= 0;
        isLast = widget.lastDate.dateCompareTo(monthDateRange.end) <= 0;
        nextView = widget.lastDate.difference(widget.firstDate).inDays > 28;
        break;
      case _PickerViewMode.month:
        navTitle = Container(
          height: _kActionHeight,
          alignment: Alignment.center,
          child: Text(
            _startDate.year.toString(),
            style: theme.textTheme.bodyLarge
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        );
        isFirst = _startDate.year <= widget.firstDate.year;
        isLast = _startDate.year >= widget.lastDate.year;
        nextView = widget.lastDate.year != widget.firstDate.year;
        break;
      case _PickerViewMode.year:
        final year = _startDate.year - _startDate.year % 20;
        isFirst = year <= widget.firstDate.year;
        isLast = year + 20 >= widget.lastDate.year;
        navTitle = Container(
          height: _kActionHeight,
          alignment: Alignment.center,
          child: Text(
            "$year - ${year + 19}",
            style: theme.textTheme.bodyLarge
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        );
        nextView = widget.lastDate.year - widget.firstDate.year > 20;
        break;
      case _PickerViewMode.century:
        final year = _startDate.year - _startDate.year % 200;
        isFirst = year <= widget.firstDate.year;
        isLast = year + 200 >= widget.lastDate.year;
        navTitle = Container(
          height: _kActionHeight,
          alignment: Alignment.center,
          child: Text(
            "$year - ${year + 199}",
            style: theme.textTheme.bodyLarge
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        );
        nextView = false;
        break;
    }
    return Card(
      margin:
          const EdgeInsets.only(left: 1.0, top: 4.0, right: 1.0, bottom: 2.0),
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            /// Navigation
            Row(
              children: [
                isFirst
                    ? _iconWidget(Icons.keyboard_arrow_left,
                        color: theme.disabledColor)
                    : _iconWidget(Icons.keyboard_arrow_left,
                        onTap: () => _onStartDateChanged(next: false)),
                nextView
                    ? Expanded(
                        child: InkWell(
                          onTap: () => _onViewModeChanged(next: true),
                          borderRadius: BorderRadius.circular(4.0),
                          child: navTitle,
                        ),
                      )
                    : Expanded(child: navTitle),
                isLast
                    ? _iconWidget(Icons.keyboard_arrow_right,
                        color: theme.disabledColor)
                    : _iconWidget(Icons.keyboard_arrow_right,
                        onTap: () => _onStartDateChanged(next: true)),
              ],
            ),

            /// Month view
            ClipRRect(
              child: AnimatedSwitcher(
                duration: _kSlideTransitionDuration,
                transitionBuilder: (child, animation) {
                  if (_isViewModeChanged) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  } else {
                    double dx = (child.key as _PickerKey).date == _startDate
                        ? 1.0
                        : -1.0;
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(dx * _slideDirection, 0.0),
                              end: const Offset(0.0, 0.0))
                          .animate(animation),
                      child: child,
                    );
                  }
                },
                child: _buildChild(theme),
              ),
            ),

            /// Actions
            Row(
              children: [
                /// Reset
                _iconWidget(Icons.restart_alt,
                    tooltip: "Reset", onTap: _onResetState),
                const SizedBox(width: 4.0),

                /// Today
                _iconWidget(Icons.today,
                    tooltip: "Today", onTap: _onStartDateChanged),
                const Spacer(),

                /// CANCEL
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("CANCEL"),
                ),

                /// OK
                if (_viewMode == _PickerViewMode.day) ...[
                  const SizedBox(width: 4.0),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(_selectedDate),
                    child: const Text("OK"),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconWidget(IconData icon,
      {Color? color, String? tooltip, GestureTapCallback? onTap}) {
    final child = Container(
      height: _kActionHeight,
      width: _kActionHeight,
      alignment: Alignment.center,
      child: tooltip != null
          ? Tooltip(message: tooltip, child: Icon(icon, color: color))
          : Icon(icon, color: color),
    );
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: child,
      );
    } else {
      return child;
    }
  }

  void _onStartDateChanged({bool? next}) {
    DateTime date;
    if (next != null) {
      switch (_viewMode) {
        case _PickerViewMode.day:
          date = next ? _startDate.nextMonth : _startDate.previousMonth;
          break;
        case _PickerViewMode.month:
          date = next ? _startDate.nextYear : _startDate.previousYear;
          break;
        case _PickerViewMode.year:
          final year = _startDate.year - _startDate.year % 20;
          date = next ? DateTime(year + 20) : DateTime(year - 20);
          break;
        case _PickerViewMode.century:
          final year = _startDate.year - _startDate.year % 200;
          date = next ? DateTime(year + 200) : DateTime(year - 200);
          break;
      }
    } else {
      final year20 = _startDate.year - _startDate.year % 20;
      final year200 = _startDate.year - _startDate.year % 200;
      date = DateTime.now();
      if (_viewMode == _PickerViewMode.day && date.month == _startDate.month ||
          _viewMode == _PickerViewMode.month && date.year == _startDate.year ||
          _viewMode == _PickerViewMode.year &&
              date.year >= year20 &&
              (date.year - year20) < 20 ||
          _viewMode == _PickerViewMode.century &&
              date.year >= year200 &&
              (date.year - year200) < 200) {
        return;
      }
    }
    setState(
      () {
        _slideDirection = date.isAfter(_startDate) ? 1.0 : -1.0;
        _isViewModeChanged = false;
        _startDate = date;
      },
    );
  }

  void _onViewModeChanged({required bool next, DateTime? date}) {
    setState(() {
      _isViewModeChanged = true;
      _viewMode = next ? _viewMode.next() : _viewMode.previous();
      if (date != null) {
        _startDate = date;
      }
    });
  }

  void _onResetState() {
    setState(
      () {
        _slideDirection = widget.initialDate.isAfter(_startDate) ? 1.0 : -1.0;
        _startDate = widget.initialDate;
        _selectedDate = _startDate;
        _isViewModeChanged = _viewMode != _PickerViewMode.day;
        _viewMode = _PickerViewMode.day;
      },
    );
  }

  void _onSizeChanged(Size size, Size cellSize) {
    _childSize = size;
  }
}

enum _PickerViewMode {
  day,
  month,
  year,
  century;

  _PickerViewMode next() {
    switch (this) {
      case _PickerViewMode.day:
        return _PickerViewMode.month;
      case _PickerViewMode.month:
        return _PickerViewMode.year;
      case _PickerViewMode.year:
        return _PickerViewMode.century;
      case _PickerViewMode.century:
        return _PickerViewMode.century;
    }
  }

  _PickerViewMode previous() {
    switch (this) {
      case _PickerViewMode.day:
        return _PickerViewMode.day;
      case _PickerViewMode.month:
        return _PickerViewMode.day;
      case _PickerViewMode.year:
        return _PickerViewMode.month;
      case _PickerViewMode.century:
        return _PickerViewMode.year;
    }
  }
}

class _PickerKey extends LocalKey {
  const _PickerKey({required this.date, required this.viewMode});

  final DateTime date;
  final _PickerViewMode viewMode;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _PickerKey &&
        other.date == date &&
        other.viewMode == viewMode;
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, viewMode);

  @override
  String toString() {
    return "_PickerKey(date: $date, viewMode: $viewMode)";
  }
}

const kNumberCellsOfMonth = 42;
const kNumberOfWeekday = 7;
const kNumberOfMonth = 12;

const kWeekdayNames = <String>[
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday"
];
const kWeekdayShortNames = <String>[
  "Sun",
  "Mon",
  "Tue",
  "Wed",
  "Thu",
  "Fri",
  "Sat"
];
const kWeekdayAbbreviations = <String>["S", "M", "T", "W", "T", "F", "S"];
const kMonthNames = <String>[
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];
const kMonthShortNames = <String>[
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];

extension DateTimeExtension on DateTime {
  DateTime get nextMonth => DateTime(year, month + 1);
  DateTime get previousMonth => DateTime(year, month - 1);

  DateTime get nextYear => DateTime(year + 1);
  DateTime get previousYear => DateTime(year - 1);

  DateTimeRange monthDateTimeRange(
      {bool includeTrailingAndLeadingDates = false}) {
    DateTime start = DateTime(year, month);
    if (includeTrailingAndLeadingDates) {
      start = start.subtract(Duration(days: start.weekday % kNumberOfWeekday));
    }
    DateTime end = includeTrailingAndLeadingDates
        ? start.add(const Duration(days: kNumberCellsOfMonth))
        : DateTime(year, month + 1, 0);
    return DateTimeRange(start: start, end: end);
  }

  bool isInRange(DateTimeRange range) {
    return difference(range.start).inSeconds >= 0 &&
        difference(range.end).inSeconds <= 0;
  }

  int monthCompareTo(DateTime other) {
    if (year < other.year) {
      return -1;
    } else if (year > other.year) {
      return 1;
    } else {
      if (month < other.month) {
        return -1;
      } else if (month > other.month) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  int dateCompareTo(DateTime other) {
    final cmp = monthCompareTo(other);
    if (cmp == 0) {
      if (day < other.day) {
        return -1;
      } else if (day > other.day) {
        return 1;
      } else {
        return 0;
      }
    } else {
      return cmp;
    }
  }
}

///
/// Reference: flutter/lib/src/material/popup_menu.dart
///

const Duration _kPopupTransitionDuration = Duration(milliseconds: 400);
const double _kPopupCloseIntervalEnd = 2.0 / 3.0;
const double _kPopupScreenPadding = 8.0;

/// Show a popup dialog
///
/// The [context] is the target context. This argument is required
///
/// The [builder] will be invoked to build the dialog. This argument is required
///
/// The [useRootNavigator] argument is used to determine whether to push the dialog
/// to the Navigator furthest from or nearest to the given context. By default,
/// [useRootNavigator] is true and the dialog route created by this method is pushed
/// to the root navigator
///
/// The [barrierDismissible] argument is used to indicate whether tapping on the
/// barrier will dismiss the dialog. Default is true
///
/// The [barrierColor] argument is used to specify the color of the modal barrier
/// that darkens everything below the dialog
///
/// The [asDropDown] argument will show the dialog as dropdown.
///
/// The [useTargetWidth] will show the dialog as the same width as the target
///
/// The [dialogWidth] argument define the width of dialog
///
Future<T?> showPopupDialog<T>(
  BuildContext context,
  WidgetBuilder builder, {
  bool useRootNavigator = false,
  bool barrierDismissible = true,
  Color? barrierColor,
  String? barrierLabel,
  bool asDropDown = false,
  bool useTargetWidth = false,
  double? dialogWidth,
}) {
  final navigator = Navigator.of(context, rootNavigator: useRootNavigator);
  final renderBox = context.findRenderObject()! as RenderBox;
  final overlayRenderBox =
      navigator.overlay!.context.findRenderObject()! as RenderBox;

  final position = RelativeRect.fromRect(
    Rect.fromPoints(
      renderBox.localToGlobal(renderBox.size.topLeft(Offset.zero),
          ancestor: overlayRenderBox),
      renderBox.localToGlobal(renderBox.size.bottomRight(Offset.zero),
          ancestor: overlayRenderBox),
    ),
    Offset.zero & overlayRenderBox.size,
  );

  return navigator.push(_PopupDialogRoute<T>(
    asDropDown: asDropDown,
    position: position,
    capturedThemes:
        InheritedTheme.capture(from: context, to: navigator.context),
    dialogWidth: useTargetWidth ? renderBox.size.width : dialogWidth,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
    child: builder(context),
  ));
}

class _PopupDialogRoute<T> extends PopupRoute<T> {
  _PopupDialogRoute({
    required this.asDropDown,
    required this.position,
    required this.capturedThemes,
    this.dialogWidth,
    required this.barrierDismissible,
    this.barrierColor,
    this.barrierLabel,
    required this.child,
  });

  final bool asDropDown;
  final RelativeRect position;
  final CapturedThemes capturedThemes;
  final double? dialogWidth;
  @override
  final bool barrierDismissible;
  @override
  Color? barrierColor;
  @override
  String? barrierLabel;
  final Widget child;

  @override
  Duration get transitionDuration => _kPopupTransitionDuration;

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linear,
      reverseCurve: const Interval(0.0, _kPopupCloseIntervalEnd),
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final dialog = _Dialog(
        animation: animation,
        asDropDown: asDropDown,
        width: dialogWidth,
        child: child);
    return CustomSingleChildLayout(
      delegate: _PopupDialogLayoutDelegate(
        position: position,
        avoidBounds: _avoidBounds(mediaQuery),
        asDropDown: asDropDown,
      ),
      child: capturedThemes.wrap(dialog),
    );
  }

  Set<Rect> _avoidBounds(MediaQueryData mediaQuery) {
    return DisplayFeatureSubScreen.avoidBounds(mediaQuery).toSet();
  }
}

class _PopupDialogLayoutDelegate extends SingleChildLayoutDelegate {
  _PopupDialogLayoutDelegate({
    required this.position,
    required this.avoidBounds,
    required this.asDropDown,
  });

  final RelativeRect position;
  final Set<Rect> avoidBounds;
  final bool asDropDown;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest)
        .deflate(const EdgeInsets.all(_kPopupScreenPadding));
  }

  @override
  Offset getPositionForChild(Size overlaySize, Size menuSize) {
    final targetWidth = overlaySize.width - position.left - position.right;
    final targetHeight = overlaySize.height - position.top - position.bottom;
    double x, y;
    if (position.left > position.right) {
      x = asDropDown ? position.left : position.left - menuSize.width;
    } else {
      x = asDropDown ? position.left : position.left + targetWidth;
    }

    if (asDropDown) {
      y = position.top + targetHeight;
    } else {
      y = position.top;
    }

    final Offset wantedPosition = Offset(x, y);
    final Offset originCenter =
        position.toRect(Offset.zero & overlaySize).center;
    final Iterable<Rect> subScreens =
        DisplayFeatureSubScreen.subScreensInBounds(
            Offset.zero & overlaySize, avoidBounds);
    final Rect subScreen = _closestScreen(subScreens, originCenter);
    return _fitInsideScreen(subScreen, menuSize, wantedPosition);
  }

  @override
  bool shouldRelayout(covariant _PopupDialogLayoutDelegate oldDelegate) {
    return position != oldDelegate.position ||
        !setEquals(avoidBounds, oldDelegate.avoidBounds) ||
        asDropDown != oldDelegate.asDropDown;
  }

  Rect _closestScreen(Iterable<Rect> screens, Offset point) {
    Rect closest = screens.first;
    for (final Rect screen in screens) {
      if ((screen.center - point).distance <
          (closest.center - point).distance) {
        closest = screen;
      }
    }
    return closest;
  }

  Offset _fitInsideScreen(Rect screen, Size menuSize, Offset wantedPosition) {
    double x = wantedPosition.dx;
    double y = wantedPosition.dy;
    if (x < screen.left + _kPopupScreenPadding) {
      x = screen.left + _kPopupScreenPadding;
    } else if (x + menuSize.width > screen.right - _kPopupScreenPadding) {
      x = screen.right - menuSize.width - _kPopupScreenPadding;
    }
    if (y < screen.top + _kPopupScreenPadding) {
      y = _kPopupScreenPadding;
    } else if (y + menuSize.height > screen.bottom - _kPopupScreenPadding) {
      y = screen.bottom - menuSize.height - _kPopupScreenPadding;
    }

    return Offset(x, y);
  }
}

class _Dialog extends StatelessWidget {
  const _Dialog({
    required this.animation,
    required this.asDropDown,
    this.width,
    required this.child,
  });

  final Animation<double> animation;
  final bool asDropDown;
  final double? width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final sizeAnimation = CurveTween(curve: const Interval(0.0, 1.0 / 2.5));
    final opacityAnimation = CurveTween(curve: const Interval(0.0, 1.0 / 3.0));
    Widget dialog = SingleChildScrollView(child: child);

    if (width != null) {
      dialog = SizedBox(width: width, child: dialog);
    }

    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: opacityAnimation.animate(animation),
          child: ClipRect(
            clipBehavior: Clip.antiAlias,
            child: Align(
              widthFactor: asDropDown ? 1.0 : sizeAnimation.evaluate(animation),
              heightFactor:
                  asDropDown ? sizeAnimation.evaluate(animation) : 1.0,
              child: child,
            ),
          ),
        );
      },
      child: dialog,
    );
  }
}

class UniformGrid extends MultiChildRenderObjectWidget {
  /// Render the same column width grid
  const UniformGrid({
    super.key,
    super.children,
    required this.columnCount,
    this.borderSide = BorderSide.none,
    this.squareCell = false,
    this.withHeader = true,
    this.onSizeChanged,
    this.fixedSize,
  });

  /// The number of column
  final int columnCount;

  /// Define the [BorderSide] of the grid
  final BorderSide borderSide;

  /// The square cells which have height equal width (= GridWidth / columnCount)
  final bool squareCell;

  /// The top row is header row which have height different with other row
  final bool withHeader;

  /// Invoked when grid size or cell size changed
  final UniformGridSizeChangedCallback? onSizeChanged;

  /// Define the size of cell
  final Size? fixedSize;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderUniformGrid(
      columnCount: columnCount,
      borderSide: borderSide,
      squareCell: squareCell,
      withHeader: withHeader,
      onSizeChanged: onSizeChanged,
      fixedSize: fixedSize,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    (renderObject as RenderUniformGrid)
      ..columnCount = columnCount
      ..borderSide = borderSide
      ..squareCell = squareCell
      ..withHeader = withHeader
      ..onSizeChanged = onSizeChanged
      ..fixedSize = fixedSize;
  }
}

typedef UniformGridSizeChangedCallback = void Function(
    Size size, Size cellSize);

class _ParentData extends ContainerBoxParentData<RenderBox> {}

class RenderUniformGrid extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _ParentData> {
  RenderUniformGrid({
    required int columnCount,
    BorderSide borderSide = BorderSide.none,
    bool squareCell = false,
    bool withHeader = true,
    UniformGridSizeChangedCallback? onSizeChanged,
    Size? fixedSize,
  })  : _columnCount = columnCount,
        _borderSide = borderSide,
        _squareCell = squareCell,
        _withHeader = withHeader,
        _onSizeChanged = onSizeChanged,
        _fixedSize = fixedSize;

  int get columnCount => _columnCount;
  int _columnCount;
  set columnCount(int value) {
    if (_columnCount == value) {
      return;
    }
    _columnCount = value;
    markNeedsLayout();
  }

  BorderSide get borderSide => _borderSide;
  BorderSide _borderSide;
  set borderSide(BorderSide value) {
    if (_borderSide == value) {
      return;
    }
    _borderSide = value;
    markNeedsPaint();
  }

  bool get squareCell => _squareCell;
  bool _squareCell;
  set squareCell(bool value) {
    if (_squareCell == value) {
      return;
    }
    _squareCell = value;
    markNeedsLayout();
  }

  bool get withHeader => _withHeader;
  bool _withHeader;
  set withHeader(bool value) {
    if (_withHeader == value) {
      return;
    }
    _withHeader = value;
    markNeedsLayout();
  }

  UniformGridSizeChangedCallback? _onSizeChanged;
  set onSizeChanged(UniformGridSizeChangedCallback? value) {
    if (_onSizeChanged == value) {
      return;
    }
    _onSizeChanged = value;
  }

  Size? get fixedSize => _fixedSize;
  Size? _fixedSize;
  set fixedSize(Size? value) {
    if (_fixedSize == value) {
      return;
    }
    _fixedSize = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! _ParentData) {
      child.parentData = _ParentData();
    }
  }

  @override
  void performLayout() {
    final width = _fixedSize?.width ?? constraints.maxWidth;
    final height = _fixedSize?.height ?? constraints.maxHeight;
    final delta = _borderSide == BorderSide.none ? 0 : _borderSide.width / 2;
    final childWidth = (width - delta * 2) / columnCount;
    double headerHeight = 0;
    int index = 0;
    RenderBox? child = firstChild;

    /// layout headers
    if (_withHeader) {
      while (child != null) {
        final childParentData = child.parentData as _ParentData;
        child.layout(BoxConstraints.tightFor(width: childWidth),
            parentUsesSize: true);
        childParentData.offset = Offset(delta + childWidth * index, 0);
        headerHeight = math.max(headerHeight, child.size.height);
        child = childParentData.nextSibling;
        if (++index == columnCount) {
          break;
        }
      }
    }

    /// layout cells
    final rowCount = _withHeader
        ? ((childCount - columnCount) / columnCount).floor()
        : (childCount / columnCount).floor();
    final childHeight =
        _squareCell ? childWidth : (height - headerHeight - delta) / rowCount;
    while (child != null) {
      final childParentData = child.parentData as _ParentData;
      final rowIndex =
          _withHeader ? index ~/ columnCount - 1 : index ~/ columnCount;
      child.layout(
          BoxConstraints.tightFor(width: childWidth, height: childHeight),
          parentUsesSize: true);
      childParentData.offset = Offset(
          delta + childWidth * (index % columnCount),
          headerHeight + childHeight * rowIndex);
      child = childParentData.nextSibling;
      index++;
    }

    size = constraints.constrain(Size(width,
        height.isInfinite ? headerHeight + childHeight * rowCount : height));
    _onSizeChanged?.call(size, Size(childWidth, childHeight));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as _ParentData;
      context.paintChild(child, childParentData.offset + offset);
      child = childParentData.nextSibling;
    }

    if (_borderSide != BorderSide.none) {
      _paintBorder(context.canvas, offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    RenderBox? child = lastChild;
    while (child != null) {
      final childParentData = child.parentData as _ParentData;
      final bool isHit = result.addWithPaintOffset(
        offset: childParentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - childParentData.offset);
          return child!.hitTest(result, position: transformed);
        },
      );
      if (isHit) {
        return true;
      }
      child = childParentData.previousSibling;
    }
    return false;
  }

  void _paintBorder(Canvas canvas, Offset offset) {
    final delta = _borderSide == BorderSide.none ? 0.0 : _borderSide.width / 2;
    if (_withHeader) {
      offset = offset.translate(delta, firstChild!.size.height);
    }
    final width = size.width - delta * 2;
    final height = _withHeader
        ? size.height - delta - firstChild!.size.height
        : size.height - delta;
    final Paint paint = Paint()
      ..color = _borderSide.color
      ..strokeWidth = _borderSide.width
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..moveTo(offset.dx, offset.dy)
      ..lineTo(offset.dx + width, offset.dy)
      ..lineTo(offset.dx + width, offset.dy + height)
      ..lineTo(offset.dx, offset.dy + height)
      ..lineTo(offset.dx, offset.dy);

    final childWidth = firstChild!.size.width;
    for (int i = _withHeader ? 1 : 0; i < columnCount; i++) {
      path
        ..moveTo(offset.dx + i * childWidth, offset.dy)
        ..lineTo(offset.dx + i * childWidth, offset.dy + height);
    }

    final rowCount =
        ((childCount - (_withHeader ? columnCount : 0)) / columnCount).floor();
    final childHeight = height / rowCount;
    for (int i = _withHeader ? 1 : 0; i < rowCount; i++) {
      path
        ..moveTo(offset.dx, offset.dy + i * childHeight)
        ..lineTo(offset.dx + width, offset.dy + i * childHeight);
    }
    canvas.drawPath(path, paint);
  }
}
