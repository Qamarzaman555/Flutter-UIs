part of '../local_pub.dart';

class CHIToggleBar extends StatelessWidget {
  final void Function(int) onItemChanged;
  final List<String> lables;
  final int selectedIndex;
  final EdgeInsets? margin;
  const CHIToggleBar({
    super.key,
    required this.lables,
    required this.selectedIndex,
    required this.onItemChanged,
    this.margin,
  }) : assert(lables.length == 2, 'Lables Length should be 2.');
  @override
  Widget build(BuildContext context) {
    return CHICard(
      margin: margin,
      padding: 4.padAll,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          _tab(
            lables.first,
            selectedIndex == 0
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            selectedIndex == 0
                ? Colors.white
                : Theme.of(context).extension<CHITheme>()!.secondryColor!,
            onTap: () => onItemChanged(0),
          ),
          _tab(
            lables.last,
            selectedIndex == 1 ? CHIStyles.primaryColor : Colors.transparent,
            selectedIndex == 1
                ? Colors.white
                : Theme.of(context).extension<CHITheme>()!.secondryColor!,
            onTap: () => onItemChanged(1),
          ),
        ],
      ),
    );
  }

  Widget _tab(String lable, Color backgroundColor, Color foregroundColor,
      {VoidCallback? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: 12.padAll,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            lable,
            style: CHIStyles.smMediumStyle.copyWith(color: foregroundColor),
          ),
        ),
      ),
    );
  }
}
