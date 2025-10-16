part of 'bluetooth_devices_scanner.dart';

@immutable
class BluetoothDeviceTileTheme
    extends BluetoothDeviceSimpleConnectionTileTheme {
  const BluetoothDeviceTileTheme({
    required super.connectedColor,
    required super.disconnectedColor,
    required super.highlightColor,
    required super.selectedColor,
    required super.connectedIcon,
    required super.disconnectedIcon,
    required super.nullRssiIcon,
  });
}
