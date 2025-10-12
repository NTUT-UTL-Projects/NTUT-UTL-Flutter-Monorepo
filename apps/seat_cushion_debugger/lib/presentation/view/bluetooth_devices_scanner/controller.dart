part of 'bluetooth_devices_scanner.dart';

class BluetoothDevicesScannerController extends ChangeNotifier with BluetoothDevicesController {

  BluetoothDevicesScannerController({
    required bool fbpIsSupported,
    required List<fbp.BluetoothDevice> fbpSystemDevices,
  }) {
    init(
      fbpIsSupported: fbpIsSupported,
      fbpSystemDevices: fbpSystemDevices,
    );
  }

  @override
  List<BluetoothDevice> get devices => super.devices
    .toList()
    ..sort((a, b) {
      if(a.name.isNotEmpty && b.name.isNotEmpty) {
        return a.name.compareTo(b.name);
      } else if(a.name.isNotEmpty && b.name.isEmpty) {
        return -1;
      }
      else if(a.name.isEmpty && b.name.isNotEmpty) {
        return 1;
      }
      else {
        return 0;
      }
    });

  @override
  void dispose() {
    super.cancelDevicesController();
    super.dispose();
  }

}