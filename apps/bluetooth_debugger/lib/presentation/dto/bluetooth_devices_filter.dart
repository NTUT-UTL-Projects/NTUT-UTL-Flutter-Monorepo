import 'package:bluetooth_presentation/bluetooth_presentation.dart';
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

typedef BluetoothDevicesFilterToIcon =
    IconData Function(BluetoothDevicesFilter filter);

mixin BluetoothDevicesFilterController on ChangeNotifier {
  final Map<BluetoothDevicesFilter, bool> _bluetoothDevicesFilter = {
    for (var k in BluetoothDevicesFilter.values) k: false,
  };

  /// Check the specific filter state.
  bool chekcBluetoothDevicesFilter(BluetoothDevicesFilter filter) =>
      _bluetoothDevicesFilter[filter]!;

  /// Set the specific filter state.
  void setBluetoothDevicesFilter({
    required BluetoothDevicesFilter filter,
    required bool value,
  }) {
    final v = _bluetoothDevicesFilter[filter]!;
    if (v == value) return;
    _bluetoothDevicesFilter.update(filter, (_) => value);
    notifyListeners();
    return;
  }

  /// Toggle the specific filter state.
  void toggleBluetoothDevicesFilter(BluetoothDevicesFilter filter) {
    _bluetoothDevicesFilter.update(filter, (value) => !value);
    notifyListeners();
    return;
  }

  /// Applies the active Bluetooth device filters and returns the matching devices.
  ///
  /// This method filters the given [devices] list based on the enabled
  /// [BluetoothDevicesFilter] options.
  Iterable<T> bluetoothDevicesFilter<T extends BluetoothDevice>(
    Iterable<T> devices,
  ) {
    return devices
        .where((d) {
          if (chekcBluetoothDevicesFilter(
            BluetoothDevicesFilter.inSystem,
          )) {
            return d.inSystem;
          } else {
            return true;
          }
        })
        .where((d) {
          if (chekcBluetoothDevicesFilter(
            BluetoothDevicesFilter.isConnectable,
          )) {
            return d.isConnectable;
          } else {
            return true;
          }
        })
        .where((d) {
          if (chekcBluetoothDevicesFilter(
            BluetoothDevicesFilter.isConnected,
          )) {
            return d.isConnected;
          } else {
            return true;
          }
        })
        .where((d) {
          if (chekcBluetoothDevicesFilter(
            BluetoothDevicesFilter.nameIsNotEmpty,
          )) {
            return d.name.isNotEmpty;
          } else {
            return true;
          }
        });
  }
}
