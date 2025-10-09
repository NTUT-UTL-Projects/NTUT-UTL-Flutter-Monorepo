part of 'bluetooth_devices_scanner.dart';

class BluetoothDevicesScannerController extends ChangeNotifier with BluetoothDevicesController {

  // Flutter Blue Plus
  fbp.BluetoothDevice? _fbpSelectedDevice;
  fbp.BluetoothDevice? get fbpSelectedDevice => _fbpSelectedDevice;

  BluetoothDevicesScannerController({
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
    super.cancel();
    super.dispose();
  }

  BluetoothDevice? get selectedDevice {
    return super.devices
      .where((d) => 
        d.id == _fbpSelectedDevice?.remoteId.str
      )
      .firstOrNull;
  }

}