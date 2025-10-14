part of 'seat_cushion_features_line.dart';

class SeatCushionFeaturesLineIcons {
  final IconData clear;
  final IconData download;
  final IconData record;

  SeatCushionFeaturesLineIcons({
    required this.clear,
    required this.download,
    required this.record,
  });
}

@immutable
class SeatCushionFeaturesLineTheme
    extends ThemeExtension<SeatCushionFeaturesLineTheme> {
  const SeatCushionFeaturesLineTheme({
    required this.clearIconColor,
    required this.downloadIconColor,
    required this.recordIconColor,
  });

  final Color clearIconColor;
  final Color downloadIconColor;
  final Color recordIconColor;

  @override
  SeatCushionFeaturesLineTheme copyWith({
    Color? clearIconColor,
    Color? downloadIconColor,
    Color? recordIconColor,
  }) => SeatCushionFeaturesLineTheme(
    clearIconColor: clearIconColor ?? this.clearIconColor,
    downloadIconColor: downloadIconColor ?? this.downloadIconColor,
    recordIconColor: recordIconColor ?? this.recordIconColor,
  );

  @override
  SeatCushionFeaturesLineTheme lerp(
    ThemeExtension<SeatCushionFeaturesLineTheme>? other,
    double t,
  ) {
    if (other is! SeatCushionFeaturesLineTheme) return this;
    return SeatCushionFeaturesLineTheme(
      clearIconColor:
          Color.lerp(
            clearIconColor as Color?,
            other.clearIconColor as Color?,
            t,
          ) ??
          clearIconColor,
      downloadIconColor:
          Color.lerp(
            downloadIconColor as Color?,
            other.downloadIconColor as Color?,
            t,
          ) ??
          downloadIconColor,
      recordIconColor:
          Color.lerp(
            recordIconColor as Color?,
            other.recordIconColor as Color?,
            t,
          ) ??
          recordIconColor,
    );
  }
}
