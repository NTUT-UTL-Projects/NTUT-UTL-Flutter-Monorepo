part of 'home_page.dart';

@immutable
class AllSeatCushionForces3DMeshWidgetTheme
    extends AllSeatCushion3DMeshWidgetTheme {
  AllSeatCushionForces3DMeshWidgetTheme({
    required super.baseColor,
    required double forceScale,
    required Color Function(double force) forceToColor,
    required super.strokeColor,
  }) : super(
         pointToColor: (point) => forceToColor(point.force),
         pointToHeight: (point) => point.force * forceScale,
       );
}

@immutable
class AllSeatCushionForces3DMeshWidget
    extends AllSeatCushion3DMeshView<AllSeatCushionForces3DMeshWidgetTheme> {
  const AllSeatCushionForces3DMeshWidget({super.key});
}

@immutable
@TailorMixin()
class HomePageTheme extends ThemeExtension<HomePageTheme>
    with _$HomePageThemeTailorMixin {
  @override
  final IconData bluetoothScannerIcon;
  @override
  final IconData seatCushion3DMeshIcon;
  @override
  final IconData seatCushionDashboardIcon;

  const HomePageTheme({
    required this.bluetoothScannerIcon,
    required this.seatCushion3DMeshIcon,
    required this.seatCushionDashboardIcon,
  });
}
