// ignore_for_file: use_build_context_synchronously, must_be_immutable

part of '../local_pub.dart';

class CHIDateTimePicker extends StatefulWidget {
  final DateTime? lastDate;
  final String title;
  final DateTime? firstDate;
  final Function(int? data) onGetDateTime;
  final String? dateFormate;
  final String? icon;
  final PickerType pickerType;
  final bool disabled;
  DateTime? selectedDate;
  DateTime? initialDate;

  CHIDateTimePicker({
    super.key,
    this.lastDate,
    required this.title,
    this.firstDate,
    required this.onGetDateTime,
    this.dateFormate,
    this.pickerType = PickerType.both,
    this.icon,
    this.selectedDate,
    this.initialDate,
    this.disabled = false,
  });

  @override
  State<CHIDateTimePicker> createState() => _CHIDateTimePickerState();
}

class _CHIDateTimePickerState extends State<CHIDateTimePicker> {
  String? pickedDateTime;

  @override
  Widget build(BuildContext context) {
    return CHICard(
        padding: const EdgeInsets.only(left: 16),
        height: 48,
        onTap: widget.disabled
            ? null
            : () async {
                FocusScope.of(context).unfocus();
                widget.selectedDate = await datePicker(
                  context,
                  firstDate: widget.firstDate,
                  lastDate: widget.lastDate,
                  selectedDate: widget.selectedDate ??
                      widget.initialDate ??
                      DateTime.now(),
                  pickerType: widget.pickerType,
                );
                pickedDateTime =
                    DateFormat(widget.dateFormate).format(widget.selectedDate!);
                widget
                    .onGetDateTime(widget.selectedDate!.millisecondsSinceEpoch);
                debugPrint('$pickedDateTime');
                setState(() {});
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              pickedDateTime ?? widget.title,
              style: CHIStyles.mdNormalStyle,
            ),
            SvgPicture.asset(widget.icon ?? 'assets/icons/calender.svg',
                fit: BoxFit.scaleDown),
          ],
        ));
  }
}

Future<DateTime> datePicker(
  BuildContext context, {
  DateTime? lastDate,
  required DateTime selectedDate,
  PickerType pickerType = PickerType.both,
  DateTime? firstDate,
}) async {
  if (pickerType == PickerType.date) {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
      builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme:
                ColorScheme.light(primary: Theme.of(context).primaryColor),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor),
            ),
          ),
          child: child!),
    );
    if (selected != null && selected != selectedDate) {
      selectedDate = selected;
    }
  } else if (pickerType == PickerType.time) {
    final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme:
                  ColorScheme.light(primary: Theme.of(context).primaryColor),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor),
              ),
            ),
            child: child!));
    if (time != null) {
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        time.hour,
        time.minute,
      );
    }
  } else {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
      builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme:
                ColorScheme.light(primary: Theme.of(context).primaryColor),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor),
            ),
          ),
          child: child!),
    );
    if (selected != null && selected != selectedDate) {
      final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) => Theme(
              data: Theme.of(context).copyWith(
                colorScheme:
                    ColorScheme.light(primary: Theme.of(context).primaryColor),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor),
                ),
              ),
              child: child!));
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        time!.hour,
        time.minute,
      );
    }
  }
  return selectedDate;
}

enum PickerType { date, time, both }
