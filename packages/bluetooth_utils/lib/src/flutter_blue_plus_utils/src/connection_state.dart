part of '../flutter_blue_plus_utils.dart';

extension ConnectionStateFlutterBluePlus on FlutterBluePlus {
  static Stream<BluetoothDevice> get onConnectionStateChanged =>
      FlutterBluePlusPlatform.instance.onConnectionStateChanged.map(
        (p) => BluetoothDevice.fromId(p.remoteId.str),
      );
}
