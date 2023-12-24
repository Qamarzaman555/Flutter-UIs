part of '../local_pub.dart';

class CHISegmentedSlider extends StatelessWidget {
  final double value;
  final void Function(double)? onChanged;

  const CHISegmentedSlider({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final List<String> divisions = List.generate(11, (index) => "$index");
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 5,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.green, Colors.red],
              )),
            ),
            SliderTheme(
              data:
                  SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
              child: Slider(
                value: value,
                onChanged: onChanged,
                thumbColor:
                    Theme.of(context).extension<CHITheme>()?.primaryColor,
                activeColor: Colors.transparent,
                divisions: divisions.length,
                inactiveColor: Colors.transparent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: divisions
              .map((d) => Column(
                    children: [
                      const Text("|"),
                      Text(d),
                    ],
                  ))
              .toList(),
        ),
      ],
    );
  }
}
