// ignore_for_file: must_be_immutable

part of '../local_pub.dart';

class CHIDateRangePicker extends StatelessWidget {
  CHIDateRangePicker(
      {super.key,
      required this.title,
      required this.onGetRanges,
      required this.format,
      this.icon});

  List<String>? ranges;
  String title;
  String format;
  String? icon;
  Function(List<int?>) onGetRanges;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return CHICard(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                ranges == null
                    ? 'Select Date Range'
                    : '${ranges![0]}  -  ${ranges![1]}',
                style: CHIStyles.mdNormalStyle
                    .copyWith(color: ranges == null ? Colors.grey : null)),
            SvgPicture.asset(icon ?? 'assets/icons/calender.svg',
                fit: BoxFit.scaleDown),
          ],
        ),
        onTap: () async {
          final values = await showCalendarDatePicker2Dialog(
            context: context,
            config: onConfig(context),
            dialogSize: Size(MediaQuery.of(context).size.width / 0.8,
                MediaQuery.of(context).size.height / 2.8),
            borderRadius: BorderRadius.circular(8),
          );
          if (values != null) {
            List<int> rangesInTimestamp = [];
            ranges = onSelectRanges(values, format);
            rangesInTimestamp.add(values[0]!.millisecondsSinceEpoch);
            rangesInTimestamp.add(values[1]!.millisecondsSinceEpoch);
            onGetRanges(rangesInTimestamp);
            setState(
              () {},
            );
          }
        },
      );
    });
  }

  List<String> onSelectRanges(values, String format) {
    String startDate = DateFormat(format).format(values[0]);
    String endDate = DateFormat(format).format(values[1]);
    return [startDate, endDate];
  }
}

CalendarDatePicker2WithActionButtonsConfig onConfig(BuildContext context) {
  final config = CalendarDatePicker2WithActionButtonsConfig(
      weekdayLabels: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'],
      lastDate: DateTime.now(),
      cancelButtonTextStyle: TextStyle(
          color: Theme.of(context).extension<CHITheme>()?.primaryColor),
      okButtonTextStyle: TextStyle(
          color: Theme.of(context).extension<CHITheme>()?.primaryColor),
      dayTextStyle: const TextStyle(fontWeight: FontWeight.w500),
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor:
          Theme.of(context).extension<CHITheme>()?.primaryColor,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ));
  return config;
}
