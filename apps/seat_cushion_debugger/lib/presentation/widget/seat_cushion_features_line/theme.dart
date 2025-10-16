part of 'seat_cushion_features_line.dart';

@immutable
@TailorMixin()
class SeatCushionFeaturesLineTheme
    extends ThemeExtension<SeatCushionFeaturesLineTheme>
    with _$SeatCushionFeaturesLineThemeTailorMixin {
  @override
  final Color clearColor;
  @override
  final IconData clearIcon;
  @override
  final Color downloadColor;
  @override
  final IconData downloadIcon;
  @override
  final Color recordColor;
  @override
  final IconData recordIcon;

  const SeatCushionFeaturesLineTheme({
    required this.clearColor,
    required this.clearIcon,
    required this.downloadColor,
    required this.downloadIcon,
    required this.recordColor,
    required this.recordIcon,
  });
}
