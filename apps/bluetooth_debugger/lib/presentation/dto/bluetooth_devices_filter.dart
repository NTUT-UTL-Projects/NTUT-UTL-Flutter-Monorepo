import 'package:bluetooth_utils/persentation/tile/details/tile.dart';
import 'package:flutter/material.dart';

/// Filter options for Bluetooth devices.
enum BluetoothDevicesFilter {
  inSystem,
  // isClassic,
  isConnected,
  isConnectable,
  // isHighSpeed,
  // isLowPower,
  // isScanned,
  nameIsNotEmpty,
}

class BluetoothDevicesFilterIcons {
  final IconData Function(BluetoothDevicesFilter filter) get;

  BluetoothDevicesFilterIcons({required this.get});
}

mixin BluetoothDevicesFilterController on ChangeNotifier {
  final Map<BluetoothDevicesFilter, bool> _bluetoothDevicesFilter = { for (var k in BluetoothDevicesFilter.values) k : false };
  
  bool chekcBluetoothDevicesFilter(BluetoothDevicesFilter filter) => _bluetoothDevicesFilter[filter]!;
  
  void setBluetoothDevicesFilter({
    required BluetoothDevicesFilter filter,
    required bool value,
  }) {
    final v = _bluetoothDevicesFilter[filter]!;
    if(v == value) return;
    _bluetoothDevicesFilter.update(filter, (_) => value);
    notifyListeners();
    return;
  }
  
  void toggleBluetoothDevicesFilter(BluetoothDevicesFilter filter) {
    _bluetoothDevicesFilter.update(filter, (value) => !value);
    notifyListeners();
    return;
  }

  Iterable<T> bluetoothDevicesFilter<T extends BluetoothDevice>(Iterable<T> devices) {
    return devices
      .where((d) {
        if(chekcBluetoothDevicesFilter(BluetoothDevicesFilter.inSystem)) {
          return d.inSystem;
        } else {
          return true;
        }
      })
      .where((d) {
        if(chekcBluetoothDevicesFilter(BluetoothDevicesFilter.isConnectable)) {
          return d.isConnectable;
        } else {
          return true;
        }
      })
      .where((d) {
        if(chekcBluetoothDevicesFilter(BluetoothDevicesFilter.isConnected)) {
          return d.isConnected;
        } else {
          return true;
        }
      })
      .where((d) {
        if(chekcBluetoothDevicesFilter(BluetoothDevicesFilter.nameIsNotEmpty)) {
          return d.name.isNotEmpty;
        } else {
          return true;
        }
      });
  }

}
