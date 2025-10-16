part of 'seat_cushion_force_color_bar.dart';

@immutable
@TailorMixin()
class SeatCushionForceColorBarTheme
    extends ThemeExtension<SeatCushionForceColorBarTheme>
    with _$SeatCushionForceColorBarThemeTailorMixin {
  @override
  final ForceToColorConverter forceToColor;

  const SeatCushionForceColorBarTheme({required this.forceToColor});
}
