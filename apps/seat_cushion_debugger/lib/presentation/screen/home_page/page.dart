part of 'home_page.dart';

typedef ForceToColorConverter = Color Function(ThemeData, double);

class SeatCushionForces3DMeshWidgetUI extends SeatCushion3DMeshWidgetUI {
  @override
  final double cameraHight;
  
  @override
  final double focusLength;

  final double focusScale;

  SeatCushionForces3DMeshWidgetUI({
    required this.cameraHight,
    required this.focusLength,
    required this.focusScale,
  });
  
  @override
  Color pointToColor(ThemeData themeData, SeatCushionUnitCornerPoint point) {
    return weiZheForceToColorConverter(themeData, point.force);
  }
  
  @override
  double pointToHeight(ThemeData themeData, SeatCushionUnitCornerPoint point) {
    return point.force * focusScale;
  }
}

class SeatCushionForces3DMeshWidget extends SeatCushion3DMeshView<SeatCushionForces3DMeshWidgetUI> {
  const SeatCushionForces3DMeshWidget({super.key});
}

/// **Requirements:**
/// - [BluetoothDevicesScanner]
/// - [SeatCushionDashboard]
/// - [SeatCushionForces3DMeshWidget]
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final icons = context.watch<HomePageIcons>();
    final bluetoothScanner = BluetoothDevicesScanner();
    final seatCushionDashboard = SeatCushionDashboard();
    final seatCushionforces3DMesh = SeatCushionForces3DMeshWidget();
    final tabViewMap = {
      icons.bluetoothScanner:
      bluetoothScanner,
      icons.seatCushionDashboard:
      seatCushionDashboard,
      icons.seatCushion3DMesh:
      seatCushionforces3DMesh,
    };
    return DefaultTabController(
      length: tabViewMap.length,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: false,
          appBar: TabBar(
            isScrollable: false,
            tabs: tabViewMap.keys.map((icon) {
              return Tab(
                icon: Icon(icon),
              );
            }).toList(),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: tabViewMap.values.toList(),
          ),
        ),
      ),
    );
  }
}
