part of 'home_page.dart';

/// **References:**
/// - [AllSeatCushion3DMeshView]
/// - [BluetoothDevicesScanner]
/// - [SeatCushionDashboard]
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final themeExtension = themeData.extension<HomePageTheme>();
    final bluetoothScanner = BluetoothDevicesScanner();
    final seatCushionDashboard = SeatCushionDashboard();
    final seatCushionforces3DMesh = AllSeatCushionForces3DMeshWidget();
    final tabViewMap = {
      themeExtension?.bluetoothScannerIcon: bluetoothScanner,
      themeExtension?.seatCushionDashboardIcon: seatCushionDashboard,
      themeExtension?.seatCushion3DMeshIcon: seatCushionforces3DMesh,
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
