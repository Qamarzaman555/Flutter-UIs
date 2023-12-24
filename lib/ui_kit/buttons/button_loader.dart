part of '../local_pub.dart';

class ButtonLoader extends StatelessWidget {
  final Color color;
  const ButtonLoader(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 2,
      ),
    );
  }
}
