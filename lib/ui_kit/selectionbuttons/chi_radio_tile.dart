part of '../local_pub.dart';

class CHIRadioTile extends StatelessWidget {
  final String label;
  final Object value;
  final Object? groupValue;
  final void Function(Object?)? onChanged;

  const CHIRadioTile({
    required this.label,
    required this.value,
    required this.groupValue,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CHICard(
        onTap: onChanged == null ? null : () => onChanged!(value),
        padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: CHIStyles.mdMediumStyle.copyWith(color: Colors.grey),
              ),
            ),
            CHIRadioButton(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          ],
        ));
  }
}
