part of '../flutter_blue_plus_utils.dart';

class RssiFlutterBluePlus {
  RssiFlutterBluePlus._();

  static final Map<DeviceIdentifier, int> _rssis = {};
  static bool _initialized = false;

  static void init() {
    if (_initialized) {
      return;
    }

    _initialized = true;

    // keep track of rssi
    try {
      FlutterBluePlusPlatform.instance.onReadRssi.listen((r) {
        _rssis[r.remoteId] = r.rssi;
      });
    } on UnimplementedError {
      // ignored
    }

    // keep track of scan response
    try {
      FlutterBluePlusPlatform.instance.onScanResponse.listen((r) {
        for (final adv in r.advertisements) {
          _rssis[adv.remoteId] = adv.rssi;
        }
      });
    } on UnimplementedError {
      // ignored
    }
  }

  static Stream<BluetoothDevice> get onReadRssi => FlutterBluePlusPlatform
      .instance
      .onReadRssi
      .map((p) => BluetoothDevice.fromId(p.remoteId.str));

  static Stream<Set<BluetoothDevice>> get onScanRssi =>
      FlutterBluePlusPlatform.instance.onScanResponse.map(
        (r) => r.advertisements
            .map((p) => BluetoothDevice.fromId(p.remoteId.str))
            .toSet(),
      );

  static Stream<Set<BluetoothDevice>> get onAllRssi => _mergeStreams([
    FlutterBluePlusPlatform.instance.onScanResponse.map(
      (r) => r.advertisements
          .map((p) => BluetoothDevice.fromId(p.remoteId.str))
          .toSet(),
    ),
    FlutterBluePlusPlatform.instance.onReadRssi.map(
      (p) => {BluetoothDevice.fromId(p.remoteId.str)},
    ),
  ]);
}

extension RssiTracker on BluetoothDevice {
  Stream<int> get onReadRssi => FlutterBluePlusPlatform.instance.onReadRssi
      .where((p) => p.remoteId == remoteId)
      .map((p) => p.rssi);

  Stream<int> get onScanRssi => FlutterBluePlusPlatform.instance.onScanResponse
      .map(
        (p) =>
            p.advertisements.where((d) => d.remoteId == remoteId).firstOrNull,
      )
      .where((p) => p != null)
      .map((p) => p!.rssi);

  Stream<int> get onAllRssi => _mergeStreams([onReadRssi, onScanRssi]);

  int? get rssi {
    return RssiFlutterBluePlus._rssis[remoteId];
  }
}
