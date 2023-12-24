part of '../local_pub.dart';

class CHICheckBoxTile extends StatelessWidget {
  final Widget child;
  final bool value;
  final void Function(bool? val)? onChanged;

  const CHICheckBoxTile({
    super.key,
    required this.child,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CHICard(
      padding: 12.padX,
      borderRadius: BorderRadius.circular(16),
      child: CheckboxListTile(
        activeColor: Theme.of(context).extension<CHITheme>()?.primaryColor,
        checkboxShape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(4),
        ),
        controlAffinity: ListTileControlAffinity.trailing,
        contentPadding: EdgeInsets.zero,
        visualDensity: const VisualDensity(horizontal: -1, vertical: -1),
        value: value,
        onChanged: onChanged,
        title: child,
      ),
    );
  }
}
