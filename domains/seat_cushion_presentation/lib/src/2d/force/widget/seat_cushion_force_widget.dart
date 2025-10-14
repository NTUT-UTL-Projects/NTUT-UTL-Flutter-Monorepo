part of '../../all_seat_cushion_view.dart';

@immutable
@TailorMixin()
class SeatCushionForceWidgetTheme
    extends ThemeExtension<SeatCushionForceWidgetTheme>
    with _$SeatCushionForceWidgetThemeTailorMixin {
  @override
  final Color borderColor;
  @override
  final ForceToColorConverter forceToColor;

  const SeatCushionForceWidgetTheme({
    required this.borderColor,
    required this.forceToColor,
  });
}

/// **Themes:**
/// - [SeatCushionForceWidgetTheme]
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

    final borderWidth = min(width, height) * 1.0 / 15.0;
    final borderRadius = borderWidth;

    return Container(
      decoration: BoxDecoration(
        color: themeExtension.forceToColor(force),
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
