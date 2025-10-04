part of '../bluetooth_device_tile.dart';

enum BluetoothTech {
  unknown,
  classic,
  highSpeed,
  lowEnergy,
}

class BluetoothDevice {
  final String id;
  final bool isConnectable;
  final bool isConnected;
  final bool isScanned;
  final bool isSelected;
  final String name;
  final int rssi;
  final BluetoothTech tech;
  final VoidCallback toggleConnection;
  final VoidCallback toggleSelection;

  BluetoothDevice({required this.id, required this.isConnectable, required this.isConnected, required this.isScanned, required this.isSelected, required this.name, required this.rssi, required this.tech, required this.toggleConnection, required this.toggleSelection});

  BluetoothDevice copyWith({
    String? id,
    bool? isConnectable,
    bool? isConnected,
    bool? isScanned,
    bool? isSelected,
    String? name,
    int? rssi,
    BluetoothTech? tech,
    VoidCallback? toggleConnection,
    VoidCallback? toggleSelection,
  }) {
    return BluetoothDevice(
      id: id ?? this.id,
      isConnectable: isConnectable ?? this.isConnectable,
      isConnected: isConnected ?? this.isConnected,
      isScanned: isScanned ?? this.isScanned,
      isSelected: isSelected ?? this.isSelected,
      name: name ?? this.name,
      rssi: rssi ?? this.rssi,
      tech: tech ?? this.tech,
      toggleConnection: toggleConnection ?? this.toggleConnection,
      toggleSelection: toggleSelection ?? this.toggleSelection,
    );
  }

}
