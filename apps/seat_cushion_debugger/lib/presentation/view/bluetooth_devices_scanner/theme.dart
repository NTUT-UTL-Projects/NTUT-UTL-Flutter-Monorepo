part of 'bluetooth_devices_scanner.dart';

@immutable
class HomePageTheme extends ThemeExtension<HomePageTheme> {
  const HomePageTheme({
    required this.highlightColor,
    required this.startTaskColor,
    required this.stopTaskColor,
    required this.timestampColor,
    required this.toggleFilterColor,
  });

  final Color highlightColor;
  final Color startTaskColor;
  final Color stopTaskColor;
  final Color timestampColor;
  final Color toggleFilterColor;

  @override
  HomePageTheme copyWith({
    Color? highlightColor,
    Color? startTaskColor,
    Color? stopTaskColor,
    Color? timestampColor,
    Color? toggleFilterColor,
  }) => HomePageTheme(
        highlightColor: highlightColor ?? this.highlightColor,
        startTaskColor: startTaskColor ?? this.startTaskColor,
        stopTaskColor: stopTaskColor ?? this.stopTaskColor,
        timestampColor: timestampColor ?? this.timestampColor,
        toggleFilterColor: toggleFilterColor ?? this.toggleFilterColor,
      );

  @override
  HomePageTheme lerp(ThemeExtension<HomePageTheme>? other, double t) {
    if (other is! HomePageTheme) return this;
    return HomePageTheme(
      highlightColor: Color.lerp(
          highlightColor as Color?,
          other.highlightColor as Color?,
          t,
        ) ??
        highlightColor,
      startTaskColor: Color.lerp(
          startTaskColor as Color?,
          other.startTaskColor as Color?,
          t,
        ) ??
        startTaskColor,
      stopTaskColor: Color.lerp(
          stopTaskColor as Color?,
          other.stopTaskColor as Color?,
          t,
        ) ??
        stopTaskColor,
      timestampColor: Color.lerp(
          timestampColor as Color?,
          other.timestampColor as Color?,
          t,
        ) ??
        timestampColor,
      toggleFilterColor: Color.lerp(
          toggleFilterColor as Color?,
          other.toggleFilterColor as Color?,
          t,
        ) ??
        toggleFilterColor,
    );
  }
}