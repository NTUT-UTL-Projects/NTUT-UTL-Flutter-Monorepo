part of 'home_page.dart';

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

class AllSeatCushionForces3DMeshWidget
    extends AllSeatCushion3DMeshView<AllSeatCushionForces3DMeshWidgetTheme> {
  const AllSeatCushionForces3DMeshWidget({super.key});
}

/// **References:**
/// - [AllSeatCushion3DMeshView]
/// - [BluetoothDevicesScanner]
/// - [SeatCushionDashboard]
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final icons = context.watch<HomePageIcons>();
    final bluetoothScanner = BluetoothDevicesScanner();
    final seatCushionDashboard = SeatCushionDashboard();
    final seatCushionforces3DMesh = AllSeatCushionForces3DMeshWidget();
    final tabViewMap = {
      icons.bluetoothScanner: bluetoothScanner,
      icons.seatCushionDashboard: seatCushionDashboard,
      icons.seatCushion3DMesh: seatCushionforces3DMesh,
    };
    return DefaultTabController(
      length: tabViewMap.length,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: false,
          appBar: TabBar(
            isScrollable: false,
            tabs: tabViewMap.keys.map((icon) {
              return Tab(icon: Icon(icon));
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
