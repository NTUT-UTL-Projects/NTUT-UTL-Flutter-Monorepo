part of '../flutter_blue_plus_utils.dart';

class ScanResultFlutterBluePlus {
  ScanResultFlutterBluePlus._();

  static final Map<DeviceIdentifier, BmScanAdvertisement> _scanResponse = {};
  static bool _initialized = false;

  static void init() {
    if (_initialized) {
      return;
    }

    _initialized = true;

    // keep track of scan response
    try {
      FlutterBluePlus.isScanning.listen((isScanning) {
        if (!isScanning) return;
        _scanResponse.clear();
      });
    } on UnimplementedError {
      // ignored
    }

    // keep track of scan response
    try {
      FlutterBluePlusPlatform.instance.onScanResponse.listen((r) {
        for (final adv in r.advertisements) {
          _scanResponse[adv.remoteId] = adv;
        }
      });
    } on UnimplementedError {
      // ignored
    }
  }

  static List<ScanResult> get lastScanResults => _scanResponse
    .values
    .map((p) => ScanResult.fromProto(p))
    .toList();

  static List<BluetoothDevice> get lastScannedDevices => _scanResponse
    .values
    .map((p) => ScanResult.fromProto(p).device)
    .toList();

  static Stream<Set<BluetoothDevice>> get onScanResponse =>
      FlutterBluePlusPlatform.instance.onScanResponse.map(
        (r) => r.advertisements
            .map((p) => BluetoothDevice.fromId(p.remoteId.str))
            .toSet(),
      );
}

extension ScanResultBluetoothDevice on BluetoothDevice {
  Stream<ScanResult> get onScanResponse => FlutterBluePlusPlatform
      .instance
      .onScanResponse
      .map((p) => p.advertisements)
      .where((advs) => advs.map((p) => p.remoteId).contains(remoteId))
      .map((p) => p.firstOrNull)
      .where((p) => p != null)
      .map((p) => ScanResult.fromProto(p!));

  ScanResult? get scanResult {
    final p = ScanResultFlutterBluePlus._scanResponse[remoteId];
    if (p == null) {
      return null;
    } else {
      return ScanResult.fromProto(p);
    }
  }
}
