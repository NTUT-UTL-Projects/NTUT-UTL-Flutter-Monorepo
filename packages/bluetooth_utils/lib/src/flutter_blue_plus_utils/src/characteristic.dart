part of '../flutter_blue_plus_utils.dart';

extension CharacteristicFlutterBluePlus on FlutterBluePlus {
  static final Map<DeviceIdentifier, Map<String, List<int>>> _lastChrsReceived =
      {};
  static final Map<DeviceIdentifier, Map<String, List<int>>> _lastChrsWritten =
      {};
  static bool _initialized = false;

  static void init() {
    if (_initialized) {
      return;
    }

    _initialized = true;

    // keep track of characteristic values
    try {
      FlutterBluePlusPlatform.instance.onCharacteristicReceived.listen((r) {
        if (r.success == true) {
          String key =
              "${r.primaryServiceUuid ?? ""}:${r.serviceUuid}:${r.characteristicUuid}:${r.instanceId}";
          _lastChrsReceived[r.remoteId] ??= {};
          _lastChrsReceived[r.remoteId]![key] = r.value;
        }
      });
    } on UnimplementedError {
      // ignored
    }

    // keep track of characteristic values
    try {
      FlutterBluePlusPlatform.instance.onCharacteristicWritten.listen((r) {
        if (r.success == true) {
          String key =
              "${r.primaryServiceUuid ?? ""}:${r.serviceUuid}:${r.characteristicUuid}:${r.instanceId}";
          _lastChrsWritten[r.remoteId] ??= {};
          _lastChrsWritten[r.remoteId]![key] = r.value;
        }
      });
    } on UnimplementedError {
      // ignored
    }

    try {
      FlutterBluePlusPlatform.instance.onConnectionStateChanged.listen((r) {
        if (r.connectionState == BmConnectionStateEnum.disconnected) {
          // clear _lastChrsReceived (api consistency)
          _lastChrsReceived.remove(r.remoteId);

          // clear _lastChrsWritten (api consistency)
          _lastChrsWritten.remove(r.remoteId);
        }
      });
    } on UnimplementedError {
      // ignored
    }
  }

  static Stream<BluetoothCharacteristic> get onCharacteristicReceived =>
      FlutterBluePlusPlatform.instance.onCharacteristicReceived
          .map((p) => p.characteristic)
          .where((p) => p != null)
          .map((p) => p!);

  static Stream<BluetoothCharacteristic> get onCharacteristicWritten =>
      FlutterBluePlusPlatform.instance.onCharacteristicWritten
          .map((p) => p.characteristic)
          .where((p) => p != null)
          .map((p) => p!);

  static Stream<BluetoothCharacteristic> get onCharacteristicLastValueStream =>
      _mergeStreams([
        onCharacteristicReceived,
        onCharacteristicWritten,
      ]);

  static Stream<BluetoothCharacteristic> get onNotifyValueChanged =>
      _mergeStreams([
        FlutterBluePlusPlatform.instance.onDescriptorRead,
        FlutterBluePlusPlatform.instance.onDescriptorWritten,
      ]).map((p) => p.characteristic).where((p) => p != null).map((p) => p!);
}

extension ValueBluetoothCharacteristic on BluetoothCharacteristic {
  /// this stream emits values:
  ///   - anytime `write()` is called
  Stream<List<int>> get onValueWritten => FlutterBluePlusPlatform
      .instance
      .onCharacteristicWritten
      .where((p) => p.remoteId == remoteId)
      .where((p) => p.serviceUuid == serviceUuid)
      .where((p) => p.characteristicUuid == characteristicUuid)
      .where((p) => p.primaryServiceUuid == primaryServiceUuid)
      .where((p) => p.success == true)
      .where((p) => p.instanceId == instanceId)
      .map((c) => c.value);

  /// this variable is updated:
  ///   - anytime `read()` is called
  ///   - anytime a notification arrives (if subscribed)
  ///   - when the device is disconnected it is cleared
  List<int> get lastReceivedValue {
    String key =
        "${primaryServiceUuid ?? ""}:$serviceUuid:$characteristicUuid:$instanceId";
    return CharacteristicFlutterBluePlus._lastChrsReceived[remoteId]?[key] ??
        [];
  }

  /// this variable is updated:
  ///   - anytime `write()` is called
  ///   - when the device is disconnected it is cleared
  List<int> get lastWrittenValue {
    String key =
        "${primaryServiceUuid ?? ""}:$serviceUuid:$characteristicUuid:$instanceId";
    return CharacteristicFlutterBluePlus._lastChrsWritten[remoteId]?[key] ?? [];
  }

  Stream<bool> get onNotifyValueChanged => CharacteristicFlutterBluePlus
      .onNotifyValueChanged
      .where((p) => p.remoteId == remoteId)
      .where((p) => p.serviceUuid == serviceUuid)
      .where((p) => p.characteristicUuid == characteristicUuid)
      .where((p) => p.primaryServiceUuid == primaryServiceUuid)
      .where((p) => p.instanceId == instanceId)
      .map((c) => c.isNotifying);
}
