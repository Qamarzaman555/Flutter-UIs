part of '../local_pub.dart';

// ignore: must_be_immutable
class MultiSelectBottomSheet extends StatelessWidget {
  final List<Filter> items;
  final Function(List<String>) onSelect;
  final String title;
  final bool disabled;

  /// Multi Selection Bottomsheet `MultiSelectBottomSheet`.
  MultiSelectBottomSheet({
    super.key,
    required this.items,
    this.disabled = false,
    required this.onSelect,
    required this.title,
  });

  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return CHICard(
      height: 56,
      onTap: disabled
          ? null
          : () => showModalBottomSheet(
                context: context,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return Column(
                      children: [
                        _sheetHeader(title),
                        Expanded(
                            child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: CHICheckBoxTile(
                                value: items[index].isSelected,
                                child: Text(
                                  items[index].label!,
                                  style: CHIStyles.mdNormalStyle,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    items[index].isSelected = value!;
                                  });
                                  selectedItems.clear();
                                  for (var j in items) {
                                    if (j.isSelected) {
                                      selectedItems.add(j.label!);
                                    }
                                  }
                                  onSelect(selectedItems);
                                },
                              ),
                            );
                          },
                        )),
                      ],
                    );
                  });
                },
              ),
      child: Row(
        children: [
          Text(
            selectedItems.isEmpty
                ? title
                : '${selectedItems.length} are Selected',
            style: CHIStyles.mdNormalStyle.copyWith(color: Colors.grey),
          ),
          const Spacer(),
          if (!disabled)
            SvgPicture.asset('assets/icons/arrow_down.svg',
                fit: BoxFit.scaleDown)
        ],
      ),
    );
  }

  Widget _sheetHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Center(child: Text(title, style: CHIStyles.mdNormalStyle)),
    );
  }
}
