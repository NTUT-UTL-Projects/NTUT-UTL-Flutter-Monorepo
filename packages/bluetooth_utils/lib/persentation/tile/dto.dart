part of 'bluetooth_device_tile.dart';

enum BluetoothTech {
  unknown,
  classic,
  highSpeed,
  lowEnergy,
}

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

  BluetoothDevice({required this.id, required this.inSystem, required this.isConnectable, required this.isConnected, required this.isPaired, required this.isScanned, required this.isSelected, required this.name, required this.rssi, required this.tech, this.toggleConnection, this.togglePairing, this.toggleSelection});

  BluetoothDevice copyWith({
    String? id,
    bool? inSystem,
    bool? isPaired,
    bool? isConnectable,
    bool? isConnected,
    bool? isScanned,
    bool? isSelected,
    String? name,
    int? rssi,
    BluetoothTech? tech,
    bool copyToggleConnection = true,
    VoidCallback? toggleConnection,
    bool copyTogglePairing = true,
    VoidCallback? togglePairing,
    bool copyToggleSelection = true,
    VoidCallback? toggleSelection,
  }) {
    return BluetoothDevice(
      id: id ?? this.id,
      inSystem: inSystem ?? this.inSystem,
      isPaired: isPaired ?? this.isPaired,
      isConnectable: isConnectable ?? this.isConnectable,
      isConnected: isConnected ?? this.isConnected,
      isScanned: isScanned ?? this.isScanned,
      isSelected: isSelected ?? this.isSelected,
      name: name ?? this.name,
      rssi: rssi ?? this.rssi,
      tech: tech ?? this.tech,
      toggleConnection: toggleConnection ?? ((copyToggleConnection) ? this.toggleConnection : null),
      togglePairing: togglePairing ?? ((copyTogglePairing) ? this.togglePairing : null),
      toggleSelection: toggleSelection ?? ((copyToggleSelection) ? this.toggleSelection : null),
    );
  }

}
