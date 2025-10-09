part of '../../../seat_cushion_presentation.dart';

class SeatCushionIschiumPointWidgetTheme extends ThemeExtension<SeatCushionIschiumPointWidgetTheme> {
  Color borderColor;
  Color ischiumColor;

  SeatCushionIschiumPointWidgetTheme({
    required this.borderColor,
    required this.ischiumColor,
  });

  @override
  SeatCushionIschiumPointWidgetTheme copyWith({
    Color? borderColor,
    Color? ischiumColor,
  }) => SeatCushionIschiumPointWidgetTheme(
    borderColor: borderColor ?? this.borderColor,
    ischiumColor: ischiumColor ?? this.ischiumColor,
  );

  @override
  SeatCushionIschiumPointWidgetTheme lerp(SeatCushionIschiumPointWidgetTheme? other, double t) {
    if (other is! SeatCushionIschiumPointWidgetTheme) return this;
    return SeatCushionIschiumPointWidgetTheme(
      borderColor: Color.lerp(
          borderColor,
          other.borderColor,
          t,
        ) ??
        borderColor,
      ischiumColor: Color.lerp(
          ischiumColor,
          other.ischiumColor,
          t,
        ) ??
        ischiumColor,
    );
  }

}

class _IschiumPoint extends CustomPainter {
  final double x;
  final double y;
  final BuildContext context;
  _IschiumPoint(this.context, this.x, this.y);
  @override
  void paint(Canvas canvas, Size size) {
    final themeData = Theme.of(context);
    final themeExtension = themeData.extension<SeatCushionIschiumPointWidgetTheme>()!;
    final point = Offset(x, y);
    final innerDiameter = size.width * ((SeatCushionUnit.sensorWidth * 2.0 / 3.0) / SeatCushion.deviceWidth);
    final outerDiameter = innerDiameter * 3.0 / 2.0;
    final innerPaint = Paint()
      ..color = themeExtension.ischiumColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = innerDiameter;
    final outerPaint = Paint()
      ..color = themeExtension.borderColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = outerDiameter;
    canvas.drawPoints(PointMode.points, [point], outerPaint);
    canvas.drawPoints(PointMode.points, [point], innerPaint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class SeatCushionIschiumPointWidget<T extends SeatCushion> extends StatelessWidget {
  const SeatCushionIschiumPointWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final ischiumPosition = context.select<T?, Point<double>?>((n) => n?.ischiumPosition());
        final width = constraints.maxWidth;
        final height = width / SeatCushion.deviceAspectRatio;
        return SizedBox(
          width: width,
          height: height,
          child: (ischiumPosition != null)
            ? CustomPaint(
              painter: _IschiumPoint(
                context,
                ((ischiumPosition.x / SeatCushion.deviceWidth) + 0.5) * width,
                ((ischiumPosition.y / SeatCushion.deviceHeight) + 0.5) * height,
              ),
              child: Container(),
            )
            : null,
        );
      },
    );
  }
}
