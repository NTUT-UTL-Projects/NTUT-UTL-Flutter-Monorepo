part of '../flutter_blue_plus_utils.dart';

class BondFlutterBluePlus {
  BondFlutterBluePlus._();

  static final Map<DeviceIdentifier, BmBondStateResponse> _bondStates = {};
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) {
      return;
    }

    _initialized = true;

    // keep track of bond state
    try {
      FlutterBluePlusPlatform.instance.onBondStateChanged.listen((r) {
        _bondStates[r.remoteId] = r;
      });
    } on UnimplementedError {
      // ignored
    }
  }

  static Future<void> updateBondedDevices() async {
    for (final d in (await FlutterBluePlus.bondedDevices)) {
      if (_bondStates.containsKey(d.remoteId)) continue;
      _bondStates[d.remoteId] = BmBondStateResponse(
        remoteId: d.remoteId,
        bondState: BmBondStateEnum.bonded,
        prevState: null,
      );
    }
  }

  static List<BluetoothDevice> get bondedDevices => _bondStates.entries
      .where((p) => p.value.bondState == BmBondStateEnum.bonded)
      .map((p) => BluetoothDevice.fromId(p.key.str))
      .toList();

  static Stream<BluetoothDevice> get onBondStateChanged =>
      FlutterBluePlusPlatform.instance.onBondStateChanged.map(
        (p) => BluetoothDevice.fromId(p.remoteId.str),
      );
}

extension BondBluetoothDevice on BluetoothDevice {
  bool get isBonded => currBondState == BluetoothBondState.bonded;
  bool get isBondable => !kIsWeb && Platform.isAndroid && isConnected;
  bool get isUnBondable => !kIsWeb && Platform.isAndroid;

  /// Get the current bondState of the device (Android Only)
  BluetoothBondState? get currBondState {
    var b = BondFlutterBluePlus._bondStates[remoteId]?.bondState;
    return b != null ? _bmToBondState(b) : null;
  }

  Stream<BluetoothBondState> get onBondStateChanged => FlutterBluePlusPlatform
      .instance
      .onBondStateChanged
      .where((p) => p.remoteId == remoteId)
      .map((p) => _bmToBondState(p.bondState));
}
