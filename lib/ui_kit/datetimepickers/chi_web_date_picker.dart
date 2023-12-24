part of '../local_pub.dart';

// ignore: must_be_immutable
class CHIWebDatePicker extends StatefulWidget {
  final DateTime? lastDate;
  final DateTime? firstDate;
  final Function(int? data) onGetDateTime;
  final String? dateFormate;
  final String? icon;
  final String title;
  DateTime? selectedDate;
  DateTime? initialDate;

  CHIWebDatePicker({
    super.key,
    this.lastDate,
    this.firstDate,
    required this.title,
    required this.onGetDateTime,
    this.dateFormate,
    this.icon,
    this.selectedDate,
    this.initialDate,
  });

  @override
  State<CHIWebDatePicker> createState() => _CHIWebDatePickerState();
}

class _CHIWebDatePickerState extends State<CHIWebDatePicker> {
  String? pickedDateTime;

  @override
  Widget build(BuildContext context) {
    return CHICard(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 48,
        onTap: () async {
          FocusScope.of(context).unfocus();
          widget.selectedDate = await showWebDatePicker(
            context: context,
            initialDate: widget.selectedDate ?? DateTime.now(),
            firstDate: widget.firstDate ?? DateTime(1950),
            lastDate: widget.lastDate ?? DateTime.now(),
            width: 300,
          );
          pickedDateTime =
              DateFormat(widget.dateFormate).format(widget.selectedDate!);
          widget.onGetDateTime(widget.selectedDate!.millisecondsSinceEpoch);
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
