part of '../flutter_blue_plus_utils.dart';

extension BluetoothServicesFlutterBluePlus on FlutterBluePlus {
  static Stream<BluetoothDevice> get onDiscoveredServices =>
      FlutterBluePlusPlatform.instance.onDiscoveredServices.map(
        (p) => BluetoothDevice.fromId(p.remoteId.str),
      );

  static Stream<BluetoothDevice> get onServicesReset => FlutterBluePlusPlatform
      .instance
      .onServicesReset
      .map((p) => BluetoothDevice.fromId(p.remoteId.str));

  static Stream<BluetoothDevice> get onServicesChanged => _mergeStreams([
    onDiscoveredServices,
    onServicesReset,
    FlutterBluePlusPlatform.instance.onConnectionStateChanged
        .where((r) => r.connectionState == BmConnectionStateEnum.disconnected)
        .map((p) => BluetoothDevice.fromId(p.remoteId.str)),
  ]);
}

extension BluetoothServicesBluetoothDevice on BluetoothDevice {
  Stream<List<BluetoothService>> get onDiscoveredServices =>
      FlutterBluePlusPlatform.instance.onDiscoveredServices
          .where((p) => p.remoteId == remoteId)
          .where((p) => p.success)
          .map(
            (p) =>
                p.services.map((p) => BluetoothService.fromProto(p)).toList(),
          );

  Stream<void> get onServicesReset => FlutterBluePlusPlatform
      .instance
      .onServicesReset
      .where((p) => p.remoteId == remoteId)
      .map((_) => []);

  Stream<List<BluetoothService>> get onServicesChanged => _mergeStreams([
    onDiscoveredServices,
    onServicesReset
        .map((_) => []),
    connectionState
        .where((s) => s == BluetoothConnectionState.disconnected)
        .map((_) => []),
  ]);
}
