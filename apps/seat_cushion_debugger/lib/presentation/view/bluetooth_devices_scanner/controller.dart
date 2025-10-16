part of 'bluetooth_devices_scanner.dart';

class BluetoothDevicesScannerController extends ChangeNotifier
    with BluetoothDevicesController {
  BluetoothDevicesScannerController({
    required bool fbpIsSupported,
    required List<fbp.BluetoothDevice> fbpSystemDevices,
  }) {
    init(fbpIsSupported: fbpIsSupported, fbpSystemDevices: fbpSystemDevices);
  }

  @override
  List<BluetoothDevice> get devices =>
      super.devices.where((d) => d.name.isNotEmpty).toList();

  @override
  void dispose() {
    super.cancelDevicesController();
    super.dispose();
  }
}
