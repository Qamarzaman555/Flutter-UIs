part of '../local_pub.dart';

// ignore: must_be_immutable
class CHITabBar extends StatelessWidget {
  final int length;
  bool isScrollable;
  final List<String> tabs;
  final List<Widget> children;
  final EdgeInsets? padding;
  final bool indexed;
  final Function(int)? getIndex;
  final ScrollPhysics? physics;
  int mSelectedIndex = 0;

  CHITabBar(
      {super.key,
      required this.length,
      this.isScrollable = false,
      required this.tabs,
      required this.children,
      this.indexed = true,
      this.getIndex,
      this.physics,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState) => DefaultTabController(
              length: length,
              child: Column(
                children: [
                  Padding(
                    padding:
                        padding ?? const EdgeInsets.symmetric(horizontal: 16),
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      isScrollable: isScrollable,
                      labelColor: CHIStyles.primaryColor,
                      indicatorColor: CHIStyles.primaryColor,
                      unselectedLabelStyle: CHIStyles.mdMediumStyle
                          .copyWith(color: Colors.grey),
                      labelStyle: CHIStyles.mdMediumStyle
                          .copyWith(color: Theme.of(context).primaryColor),
                      unselectedLabelColor: Colors.grey,
                      tabs: tabs.map((tab) => Tab(text: tab)).toList(),
                      onTap: (index) {
                        setState(() {
                          mSelectedIndex = index;
                          getIndex == null ? (index) {} : getIndex!(index);
                        });
                      },
                    ),
                  ),
                  indexed
                      ? Expanded(
                          child: IndexedStack(
                            alignment: AlignmentDirectional.center,
                            index: mSelectedIndex,
                            children: children,
                          ),
                        )
                      : Expanded(
                          child: TabBarView(
                          physics: physics,
                          children: children,
                        )),
                ],
              ),
            ));
  }
}
