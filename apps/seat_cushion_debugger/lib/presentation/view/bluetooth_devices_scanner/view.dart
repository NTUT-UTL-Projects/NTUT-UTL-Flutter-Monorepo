part of 'bluetooth_devices_scanner.dart';

/// **Requirements:**
/// - [BluetoothDevicesScannerController]
/// - [BluetoothDeviceTileTheme]
class BluetoothDevicesScanner extends StatelessWidget {
  const BluetoothDevicesScanner({super.key});

  @override
  Widget build(BuildContext context) {
    final toggleScanning = context
        .select<BluetoothDevicesScannerController, VoidCallback>(
          (c) => c.toggleScanning,
        );
    return RefreshIndicator(
      onRefresh: () async {
        toggleScanning();
      },
      child: Builder(
        builder: (context) {
          final length = context.select<BluetoothDevicesScannerController, int>(
            (c) => c.devices.length,
          );
          return ListView.builder(
            itemCount: length,
            itemBuilder: (context, index) {
              return ProxyProvider<
                BluetoothDevicesScannerController,
                BluetoothDevice
              >(
                update: (_, value, _) => value.devices.elementAt(index),
                child: BluetoothDeviceSimpleConnectionTile(),
              );
            },
          );
        },
      ),
    );
  }
}
