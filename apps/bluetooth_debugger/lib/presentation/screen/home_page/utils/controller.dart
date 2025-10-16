part of '../home_page.dart';

class _ValueEditingController extends TextEditingController {}

/// **References**
/// - [BluetoothDevicesController]
/// - [BluetoothDevicesFilterController]
class HomePageController extends ChangeNotifier
    with BluetoothDevicesController, BluetoothDevicesFilterController {
  // Flutter Blue Plus
  fbp.BluetoothDevice? _fbpSelectedDevice;
  fbp.BluetoothDevice? get fbpSelectedDevice => _fbpSelectedDevice;

  HomePageController({
    required bool fbpIsSupported,
    required List<fbp.BluetoothDevice> fbpSystemDevices,
  }) {
    init(
      fbpIsSupported: fbpIsSupported,
      fbpIsSelected: (fbp.BluetoothDevice device) {
        return _fbpSelectedDevice == device;
      },
      fbpSystemDevices: fbpSystemDevices,
      fbpToggleSelection: (fbp.BluetoothDevice device) {
        _fbpSelectedDevice = fbpAllDevices
            .where((d) => d == device)
            .firstOrNull;
        notifyListeners();
        return;
      },
    );
  }

  @override
  List<BluetoothDevice> get devices =>
      bluetoothDevicesFilter(super.devices).toList();

  @override
  void dispose() {
    super.cancelDevicesController();
    super.dispose();
  }

  BluetoothDevice? get selectedDevice {
    // Flutter Blue Plus
    if (_fbpSelectedDevice != null) {
      return fbpDeviceToDevice(_fbpSelectedDevice!);
    }
    return null;
  }
}
