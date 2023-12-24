part of '../local_pub.dart';

class CHIDropDownBottomSheet extends StatelessWidget {
  final String title;
  final String? prefixIcon;
  final List<String> items;
  final Function onTap;
  final int? selectedIndex;
  final bool enableBorder;
  final bool isSearchEnabled;
  final bool disabled;
  final List<String>? searchItems;
  final bool indexed;

  const CHIDropDownBottomSheet(
      {super.key,
      required this.title,
      this.prefixIcon,
      required this.items,
      required this.onTap,
      this.enableBorder = false,
      this.disabled = false,
      this.selectedIndex,
      this.isSearchEnabled = false,
      this.indexed = true,
      this.searchItems});

  @override
  Widget build(BuildContext context) {
    return CHICard(
        border: enableBorder
            ? Border.all(
                color: Theme.of(context).extension<CHITheme>()!.borderColor!)
            : null,
        borderRadius: BorderRadius.circular(6),
        onTap: disabled
            ? null
            : () {
                FocusScope.of(context).unfocus();
                showCustomBottomSheet(
                  context,
                  title: title,
                  items: items,
                  onTap: onTap,
                  indexed: indexed,
                  selectedIndex: selectedIndex,
                  isSearchEnabled: isSearchEnabled,
                  searchItems: searchItems,
                );
              },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              if (prefixIcon != null)
                SvgPicture.asset(prefixIcon!, color: Colors.grey),
              if (prefixIcon != null) const SizedBox(width: 16),
              Text(
                selectedIndex == null ? title : items[selectedIndex!],
                style: CHIStyles.smMediumStyle.copyWith(
                    color: selectedIndex == null ? Colors.grey : null),
              ),
              const Spacer(),
              if (!disabled)
                SvgPicture.asset('assets/icons/arrow_down.svg',
                    fit: BoxFit.scaleDown)
            ],
          ),
        ));
  }
}

Future<dynamic> showCustomBottomSheet(
  context, {
  required String title,
  required List<String> items,
  required Function onTap,
  int? selectedIndex,
  bool isSearchEnabled = false,
  bool indexed = true,
  List<String>? searchItems,
}) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return FractionallySizedBox(
            heightFactor: 0.64,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                sheetHeader(title),
                isSearchEnabled
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 8),
                        child: CHITextField(
                          hintText: 'Search',
                          onChanged: (p0) {
                            setState(() {
                              if (p0 != '') {
                                searchItems = items
                                    .where((v) => v
                                        .toLowerCase()
                                        .contains(p0!.toLowerCase()))
                                    .toList();
                              } else {
                                searchItems = null;
                              }
                            });
                          },
                        ),
                      )
                    : const SizedBox(),
                Flexible(
                  child: _itemslistView(
                      searchItems ?? items, selectedIndex, onTap, indexed),
                )
              ],
            ),
          );
        });
      });
}

Widget _itemslistView(
    List<String> items, int? selectedIndex, Function onTap, bool indexed) {
  return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            CHICard(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child:
                          Text(items[index], style: CHIStyles.smMediumStyle)),
                  selectedIndex == index
                      ? const Icon(Icons.done,
                          color: Color.fromRGBO(0x4d, 0x4d, 0x4d, 1.0),
                          size: 20.0)
                      : const SizedBox.shrink(),
                ],
              ),
              onTap: () {
                indexed ? onTap(index) : onTap(items[index]);
              },
            ),
            const SizedBox(height: 8),
          ],
        );
      });
}

Widget sheetHeader(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Center(child: Text(title, style: CHIStyles.mdNormalStyle)),
  );
}
