part of '../../../seat_cushion_presentation.dart';

class SeatCushionForceWidgetTheme extends ThemeExtension<SeatCushionForceWidgetTheme> {
  Color borderColor;

  SeatCushionForceWidgetTheme({
    required this.borderColor,
  });

  @override
  SeatCushionForceWidgetTheme copyWith({
    Color? borderColor,
    Color Function(double force)? forceToColor,
  }) => SeatCushionForceWidgetTheme(
    borderColor: borderColor ?? this.borderColor,
  );

  @override
  SeatCushionForceWidgetTheme lerp(SeatCushionForceWidgetTheme? other, double t) {
    if (other is! SeatCushionForceWidgetTheme) return this;
    return SeatCushionForceWidgetTheme(
      borderColor: Color.lerp(
          borderColor,
          other.borderColor,
          t,
        ) ??
        borderColor,
    );
  }

}

class SeatCushionForceWidgetUI {
  Color Function(ThemeData themeData, double force) forceToColor;

  SeatCushionForceWidgetUI({
    required this.forceToColor,
  });

  SeatCushionForceWidgetUI copyWith({
    Color Function(ThemeData themeData, double force)? forceToColor,
  }) => SeatCushionForceWidgetUI(
    forceToColor: forceToColor ?? this.forceToColor,
  );

}

class SeatCushionForceWidget extends StatelessWidget {
  final double force;
  final double height;
  final double width;
  const SeatCushionForceWidget({
    super.key,
    required this.force,
    required this.height,
    required this.width,
  });
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final themeExtension = themeData.extension<SeatCushionForceWidgetTheme>()!;
    final ui = context.watch<SeatCushionForceWidgetUI>();
    final borderWidth = min(width, height) * 1.0 / 15.0;
    final borderRadius = borderWidth;
    return Container(
      decoration: BoxDecoration(
        color: ui.forceToColor(themeData, force),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: themeExtension.borderColor,
          width: borderWidth,
        ),
      ),
      height: height,
      width: width,
    );
  }
}
