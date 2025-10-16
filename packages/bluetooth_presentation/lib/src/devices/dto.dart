part of 'bluetooth_device_tile.dart';

enum BluetoothTech {
  unknown,
  classic,
  highSpeed,
  lowEnergy,
}

@CopyWith()
@immutable
class BluetoothDevice {
  final String id;
  final bool inSystem;
  final bool isConnectable;
  final bool isConnected;
  final bool isPaired;
  final bool isScanned;
  final bool isSelected;
  final String name;
  final int rssi;
  final BluetoothTech tech;
  final VoidCallback? toggleConnection;
  final VoidCallback? togglePairing;
  final VoidCallback? toggleSelection;

  const BluetoothDevice({
    required this.id,
    required this.inSystem,
    required this.isConnectable,
    required this.isConnected,
    required this.isPaired,
    required this.isScanned,
    required this.isSelected,
    required this.name,
    required this.rssi,
    required this.tech,
    this.toggleConnection,
    this.togglePairing,
    this.toggleSelection,
  });
}
