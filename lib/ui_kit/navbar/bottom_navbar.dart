part of '../local_pub.dart';

/// Custom Bottom Navigation Bar for CHI UI Kit.
class CHIBottomNavigationBar extends StatelessWidget {
  /// current index of the bottom navigation bar.
  final int currentIndex;

  /// children of the navigation bar.
  final List<Widget> widgets;

  /// icons of the navigation bar.
  final List<String> icons;

  /// active icons of the navigation bar.
  final List<String> activeIcons;

  /// labels of the navigation bar.
  final List<String> labels;

  /// callback [itemChanged] to be called when the item is changed.
  final void Function(int)? itemChanged;

  /// Custom Bottom Navigation Bar for CHI UI Kit.
  const CHIBottomNavigationBar({
    super.key,
    required this.currentIndex,
    this.itemChanged,
    required this.widgets,
    required this.icons,
    required this.activeIcons,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 6,
      selectedItemColor:
          Theme.of(context).extension<CHITheme>()?.selectedItemColor,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: itemChanged,
      items: [
        for (int item = 0; item < widgets.length; item++) ...{
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: SvgPicture.asset(icons[item]),
            ),
            label: labels[item],
            activeIcon: SizedBox(
              height: 24,
              child: Image.asset(activeIcons[item]),
            ),
          )
        }
      ],
    );
  }
}
