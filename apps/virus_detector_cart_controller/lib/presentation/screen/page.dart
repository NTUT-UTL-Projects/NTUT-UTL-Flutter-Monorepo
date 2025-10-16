

part of 'home_page.dart';

/// **References:**
/// - [BluetoothDevicesScanner]
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final tabViewMap = {
      "Bluetooth Scanner": BluetoothDevicesScanner(),
      "Joy Stick": JoystickView(),
    };
    return DefaultTabController(
      length: tabViewMap.length,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: false,
          appBar: TabBar(
            isScrollable: false,
            tabs: tabViewMap.keys.map((text) {
              return Text(text);
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