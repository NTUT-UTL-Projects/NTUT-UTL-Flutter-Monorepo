part of 'home_page.dart';

class CartControllerView extends StatelessWidget {
  const CartControllerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValveControllerView(),
          Divider(),
          MoveControllerView(),
        ],
      ),
    );
  }
}

/// **References:**
/// - [BluetoothDevicesScanner]
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final tabViewMap = {
      "Bluetooth Scanner": BluetoothDevicesScanner(),
      "Cart Controller": CartControllerView(),
    };
    return DefaultTabController(
      length: tabViewMap.length,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: false,
          appBar: TabBar(
            isScrollable: false,
            tabs: tabViewMap.keys.map((text) {
              return Text(
                text,
                style: Theme.of(context).textTheme.titleLarge,
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
