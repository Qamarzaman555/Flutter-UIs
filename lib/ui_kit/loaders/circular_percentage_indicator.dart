part of '../local_pub.dart';

class CirculerPercentagePaint extends CustomPainter {
  final double? currentProgress;
  final double? outerStroke;
  final double? innerStroke;

  CirculerPercentagePaint(this.currentProgress,
      {this.outerStroke, this.innerStroke});

  @override
  void paint(Canvas canvas, Size size) {
    //this is base circle
    Paint outerCircle = Paint()
      ..strokeWidth = outerStroke ?? 4
      ..color = CHIStyles.cardBorderColor
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = innerStroke ?? 4
      ..color = CHIStyles.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 10;

    canvas.drawCircle(
        center, radius, outerCircle); // this draws main outer circle

    double angle = 2 * pi * currentProgress!;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CirculerPercentageIndicater extends StatelessWidget {
  final double? size;
  final String lable;
  final double value;
  final TextStyle? lableStyle;
  final double? outerStroke;
  final double? innerStroke;

  const CirculerPercentageIndicater(
    this.value, {
    super.key,
    required this.lable,
    this.size,
    this.lableStyle,
    this.innerStroke,
    this.outerStroke,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        foregroundPainter: CirculerPercentagePaint(value,
            innerStroke: innerStroke, outerStroke: outerStroke),
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Text(
              lable,
              style: lableStyle ??
                  CHIStyles.displayXsBoldStyle
                      .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
        ));
  }
}
