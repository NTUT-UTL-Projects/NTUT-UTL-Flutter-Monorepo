part of '../home_page.dart';

@immutable
@TailorMixin()
class HomePageTheme extends ThemeExtension<HomePageTheme>
    with _$HomePageThemeTailorMixin {
  @override
  final Color appBarBackgroundColor;
  @override
  final BluetoothDevicesFilterToIcon filterToIcon;
  @override
  final Color highlightColor;
  @override
  final Color startTaskColor;
  @override
  final Color stopTaskColor;
  @override
  final Color timestampColor;
  @override
  final Color toggleFilterColor;

  const HomePageTheme({
    required this.appBarBackgroundColor,
    required this.filterToIcon,
    required this.highlightColor,
    required this.startTaskColor,
    required this.stopTaskColor,
    required this.timestampColor,
    required this.toggleFilterColor,
  });
}
