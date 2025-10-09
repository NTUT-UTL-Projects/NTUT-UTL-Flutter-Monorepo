part of 'home_page.dart';

typedef ForceToColorConverter = Color Function(ThemeData, double);

class SeatCushionForce3DMeshWidgetUI extends SeatCushion3DMeshWidgetUI {
  SeatCushionForce3DMeshWidgetUI({required super.cameraHight, required super.focusLength, required super.pointToValue, required super.valueToColor, required super.valueScale});
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final icons = context.watch<HomePageIcons>();
    final bluetoothScanner = BluetoothDevicesScanner();
    final seatCushionDashboard = SeatCushionDashboard();
    final seatCushion3DMesh = SeatCushion3DMeshView<SeatCushionForce3DMeshWidgetUI>();
    final tabViewMap = {
      icons.bluetoothScanner:
      bluetoothScanner,
      icons.seatCushionDashboard:
      seatCushionDashboard,
      icons.seatCushion3DMesh:
      seatCushion3DMesh,
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
