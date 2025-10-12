// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bluetooth_device_tile.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BluetoothDeviceCWProxy {
  BluetoothDevice id(String id);

  BluetoothDevice inSystem(bool inSystem);

  BluetoothDevice isConnectable(bool isConnectable);

  BluetoothDevice isConnected(bool isConnected);

  BluetoothDevice isPaired(bool isPaired);

  BluetoothDevice isScanned(bool isScanned);

  BluetoothDevice isSelected(bool isSelected);

  BluetoothDevice name(String name);

  BluetoothDevice rssi(int rssi);

  BluetoothDevice tech(BluetoothTech tech);

  BluetoothDevice toggleConnection(VoidCallback? toggleConnection);

  BluetoothDevice togglePairing(VoidCallback? togglePairing);

  BluetoothDevice toggleSelection(VoidCallback? toggleSelection);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BluetoothDevice(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BluetoothDevice(...).copyWith(id: 12, name: "My name")
  /// ```
  BluetoothDevice call({
    String id,
    bool inSystem,
    bool isConnectable,
    bool isConnected,
    bool isPaired,
    bool isScanned,
    bool isSelected,
    String name,
    int rssi,
    BluetoothTech tech,
    VoidCallback? toggleConnection,
    VoidCallback? togglePairing,
    VoidCallback? toggleSelection,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBluetoothDevice.copyWith(...)` or call `instanceOfBluetoothDevice.copyWith.fieldName(value)` for a single field.
class _$BluetoothDeviceCWProxyImpl implements _$BluetoothDeviceCWProxy {
  const _$BluetoothDeviceCWProxyImpl(this._value);

  final BluetoothDevice _value;

  @override
  BluetoothDevice id(String id) => call(id: id);

  @override
  BluetoothDevice inSystem(bool inSystem) => call(inSystem: inSystem);

  @override
  BluetoothDevice isConnectable(bool isConnectable) =>
      call(isConnectable: isConnectable);

  @override
  BluetoothDevice isConnected(bool isConnected) =>
      call(isConnected: isConnected);

  @override
  BluetoothDevice isPaired(bool isPaired) => call(isPaired: isPaired);

  @override
  BluetoothDevice isScanned(bool isScanned) => call(isScanned: isScanned);

  @override
  BluetoothDevice isSelected(bool isSelected) => call(isSelected: isSelected);

  @override
  BluetoothDevice name(String name) => call(name: name);

  @override
  BluetoothDevice rssi(int rssi) => call(rssi: rssi);

  @override
  BluetoothDevice tech(BluetoothTech tech) => call(tech: tech);

  @override
  BluetoothDevice toggleConnection(VoidCallback? toggleConnection) =>
      call(toggleConnection: toggleConnection);

  @override
  BluetoothDevice togglePairing(VoidCallback? togglePairing) =>
      call(togglePairing: togglePairing);

  @override
  BluetoothDevice toggleSelection(VoidCallback? toggleSelection) =>
      call(toggleSelection: toggleSelection);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BluetoothDevice(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BluetoothDevice(...).copyWith(id: 12, name: "My name")
  /// ```
  BluetoothDevice call({
    Object? id = const $CopyWithPlaceholder(),
    Object? inSystem = const $CopyWithPlaceholder(),
    Object? isConnectable = const $CopyWithPlaceholder(),
    Object? isConnected = const $CopyWithPlaceholder(),
    Object? isPaired = const $CopyWithPlaceholder(),
    Object? isScanned = const $CopyWithPlaceholder(),
    Object? isSelected = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? rssi = const $CopyWithPlaceholder(),
    Object? tech = const $CopyWithPlaceholder(),
    Object? toggleConnection = const $CopyWithPlaceholder(),
    Object? togglePairing = const $CopyWithPlaceholder(),
    Object? toggleSelection = const $CopyWithPlaceholder(),
  }) {
    return BluetoothDevice(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      inSystem: inSystem == const $CopyWithPlaceholder() || inSystem == null
          ? _value.inSystem
          // ignore: cast_nullable_to_non_nullable
          : inSystem as bool,
      isConnectable:
          isConnectable == const $CopyWithPlaceholder() || isConnectable == null
          ? _value.isConnectable
          // ignore: cast_nullable_to_non_nullable
          : isConnectable as bool,
      isConnected:
          isConnected == const $CopyWithPlaceholder() || isConnected == null
          ? _value.isConnected
          // ignore: cast_nullable_to_non_nullable
          : isConnected as bool,
      isPaired: isPaired == const $CopyWithPlaceholder() || isPaired == null
          ? _value.isPaired
          // ignore: cast_nullable_to_non_nullable
          : isPaired as bool,
      isScanned: isScanned == const $CopyWithPlaceholder() || isScanned == null
          ? _value.isScanned
          // ignore: cast_nullable_to_non_nullable
          : isScanned as bool,
      isSelected:
          isSelected == const $CopyWithPlaceholder() || isSelected == null
          ? _value.isSelected
          // ignore: cast_nullable_to_non_nullable
          : isSelected as bool,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      rssi: rssi == const $CopyWithPlaceholder() || rssi == null
          ? _value.rssi
          // ignore: cast_nullable_to_non_nullable
          : rssi as int,
      tech: tech == const $CopyWithPlaceholder() || tech == null
          ? _value.tech
          // ignore: cast_nullable_to_non_nullable
          : tech as BluetoothTech,
      toggleConnection: toggleConnection == const $CopyWithPlaceholder()
          ? _value.toggleConnection
          // ignore: cast_nullable_to_non_nullable
          : toggleConnection as VoidCallback?,
      togglePairing: togglePairing == const $CopyWithPlaceholder()
          ? _value.togglePairing
          // ignore: cast_nullable_to_non_nullable
          : togglePairing as VoidCallback?,
      toggleSelection: toggleSelection == const $CopyWithPlaceholder()
          ? _value.toggleSelection
          // ignore: cast_nullable_to_non_nullable
          : toggleSelection as VoidCallback?,
    );
  }
}

extension $BluetoothDeviceCopyWith on BluetoothDevice {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBluetoothDevice.copyWith(...)` or `instanceOfBluetoothDevice.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BluetoothDeviceCWProxy get copyWith => _$BluetoothDeviceCWProxyImpl(this);
}
