part of '../flutter_blue_plus_utils.dart';

extension DescriptorFlutterBluePlus on FlutterBluePlus {
  static final Map<DeviceIdentifier, Map<String, List<int>>> _lastDescsReceived =
      {};
  static final Map<DeviceIdentifier, Map<String, List<int>>> _lastDescsWritten =
      {};
  static bool _initialized = false;

  static void init() {
    if (_initialized) {
      return;
    }

    _initialized = true;

    // keep track of descriptor values
    try {
      FlutterBluePlusPlatform.instance.onDescriptorRead.listen((r) {
        if (r.success == true) {
          String key =
              "${r.primaryServiceUuid ?? ""}:${r.serviceUuid}:${r.characteristicUuid}:${r.instanceId}:${r.descriptorUuid}";
          _lastDescsReceived[r.remoteId] ??= {};
          _lastDescsReceived[r.remoteId]![key] = r.value;
        }
      });
    } on UnimplementedError {
      // ignored
    }

    // keep track of descriptor values
    try {
      FlutterBluePlusPlatform.instance.onDescriptorWritten.listen((r) {
        if (r.success == true) {
          String key =
              "${r.primaryServiceUuid ?? ""}:${r.serviceUuid}:${r.characteristicUuid}:${r.instanceId}:${r.descriptorUuid}";
          _lastDescsWritten[r.remoteId] ??= {};
          _lastDescsWritten[r.remoteId]![key] = r.value;
        }
      });
    } on UnimplementedError {
      // ignored
    }

    try {
      FlutterBluePlusPlatform.instance.onConnectionStateChanged.listen((r) {
        if (r.connectionState == BmConnectionStateEnum.disconnected) {
          // clear _lastDescsReceived (api consistency)
          _lastDescsReceived.remove(r.remoteId);

          // clear _lastDescsWritten (api consistency)
          _lastDescsWritten.remove(r.remoteId);
        }
      });
    } on UnimplementedError {
      // ignored
    }
  }

  static Stream<BluetoothDescriptor> get onDescriptorReceived =>
      FlutterBluePlusPlatform.instance.onDescriptorRead
          .map((p) => p.descriptor)
          .where((p) => p != null)
          .map((p) => p!);

  static Stream<BluetoothDescriptor> get onDescriptorWritten =>
      FlutterBluePlusPlatform.instance.onDescriptorWritten
          .map((p) => p.descriptor)
          .where((p) => p != null)
          .map((p) => p!);

  static Stream<BluetoothDescriptor> get onDescriptorLastValueStream =>
      _mergeStreams([onDescriptorReceived, onDescriptorWritten]);
}

extension ValueBluetoothDescriptor on BluetoothDescriptor {
  BluetoothCharacteristic? get characteristic {
    return BluetoothCharacteristic(
      remoteId: remoteId,
      primaryServiceUuid: primaryServiceUuid,
      serviceUuid: serviceUuid,
      characteristicUuid: characteristicUuid,
      instanceId: instanceId,
    );
  }

  /// this stream emits values:
  ///   - anytime `write()` is called
  Stream<List<int>> get onValueWritten => FlutterBluePlusPlatform
      .instance
      .onDescriptorWritten
      .where((p) => p.remoteId == remoteId)
      .where((p) => p.characteristicUuid == characteristicUuid)
      .where((p) => p.serviceUuid == serviceUuid)
      .where((p) => p.descriptorUuid == descriptorUuid)
      .where((p) => p.primaryServiceUuid == primaryServiceUuid)
      .where((p) => p.success == true)
      .where((p) => p.instanceId == instanceId)
      .map((p) => p.value);

  /// this variable is updated:
  ///   - anytime `read()` is called
  ///   - when the device is disconnected it is cleared
  List<int> get lastReceivedValue {
    String key =
        "${primaryServiceUuid ?? ""}:$serviceUuid:$characteristicUuid:$instanceId:$descriptorUuid";
    return DescriptorFlutterBluePlus._lastDescsReceived[remoteId]?[key] ?? [];
  }

  /// this variable is updated:
  ///   - anytime `write()` is called
  ///   - when the device is disconnected it is cleared
  List<int> get lastWrittenValue {
    String key =
        "${primaryServiceUuid ?? ""}:$serviceUuid:$characteristicUuid:$instanceId:$descriptorUuid";
    return DescriptorFlutterBluePlus._lastDescsWritten[remoteId]?[key] ?? [];
  }
}
