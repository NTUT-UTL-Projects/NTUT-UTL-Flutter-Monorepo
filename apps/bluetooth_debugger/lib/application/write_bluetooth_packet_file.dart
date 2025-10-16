import 'dart:async';
import 'dart:io';

import 'package:bluetooth_utils/bluetooth_utils.dart';
import 'package:data_utils/data_utils.dart';
import 'package:file_utils/file_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider_utils/path_provider_utils.dart';
import 'package:synchronized/synchronized.dart';

enum _Rw {
  read,
  write,
}

extension BluetoothPacketFile on File {
  static Future<File?> create() async {
    final path = await getSystemDownloadDirectory();
    if (path == null) return null;
    final packageInfo = await PackageInfo.fromPlatform();
    final appName = packageInfo.appName;
    final fileFormat = "csv";
    final file = File(
      "${path.absolute.path}/${appName}_${(DateTime.now().toFileFormat())}.$fileFormat",
    );
    await file.writeAsCsvRow(
      data: [
        "Device id",
        "Device name",
        "Layer",
        "Layer UUID",
        "Read or Write",
        "Time",
        "Bytes Length",
        "Bytes",
      ],
      mode: FileMode.write,
    );
    return file;
  }

  Future<void> _writeCharacteristic({
    required BluetoothCharacteristic charaacteristic,
    required _Rw rw,
    required List<int> value,
  }) async {
    await writeAsCsvRow(
      data: [
        charaacteristic.remoteId.str,
        charaacteristic.device.platformName,
        "Characteristic",
        charaacteristic.characteristicUuid,
        rw.name,
        DateTime.now().toString(),
        value.length,
        ...value.toByteStrings(),
      ],
    );
  }

  Future<void> _writeDescriptor({
    required BluetoothDescriptor descriptor,
    required _Rw rw,
    required List<int> value,
  }) async {
    await writeAsCsvRow(
      data: [
        descriptor.remoteId.str,
        descriptor.device.platformName,
        "Descriptor",
        descriptor.descriptorUuid,
        rw.name,
        DateTime.now().toString(),
        value.length,
        ...value.toByteStrings(),
      ],
    );
  }
}

typedef FileNameCreator = String Function(DateTime time);

class WriteBluetoothPacketFile {
  final _lock = Lock();

  File? _file;
  final FileNameCreator fileNameCreator;

  bool _isRunning = false;
  bool get isRunning => _isRunning;

  final StreamController<bool> _controller = StreamController.broadcast();
  Stream<bool> get isRunningStream => _controller.stream;

  final bool fbpIsSupported;

  final List<StreamSubscription> _sub = [];

  WriteBluetoothPacketFile({
    required this.fbpIsSupported,
    required this.fileNameCreator,
  }) {
    if (!fbpIsSupported) return;
    _sub.addAll([
      CharacteristicFlutterBluePlus.onCharacteristicReceived.listen(
        (c) => _lock.synchronized(() async {
          await _file?._writeCharacteristic(
            charaacteristic: c,
            rw: _Rw.read,
            value: c.lastReceivedValue,
          );
        }),
      ),
      CharacteristicFlutterBluePlus.onCharacteristicWritten.listen(
        (c) => _lock.synchronized(() async {
          await _file?._writeCharacteristic(
            charaacteristic: c,
            rw: _Rw.write,
            value: c.lastWrittenValue,
          );
        }),
      ),
      DescriptorFlutterBluePlus.onDescriptorReceived.listen(
        (c) => _lock.synchronized(() async {
          await _file?._writeDescriptor(
            descriptor: c,
            rw: _Rw.read,
            value: c.lastReceivedValue,
          );
        }),
      ),
      DescriptorFlutterBluePlus.onDescriptorWritten.listen(
        (c) => _lock.synchronized(() async {
          await _file?._writeDescriptor(
            descriptor: c,
            rw: _Rw.write,
            value: c.lastWrittenValue,
          );
        }),
      ),
    ]);
  }

  void start() {
    _lock.synchronized(() async {
      if (_isRunning) return;
      _isRunning = true;
      _file = await BluetoothPacketFile.create();
      _controller.add(_isRunning);
    });
  }

  void stop() {
    _lock.synchronized(() async {
      if (!_isRunning) return;
      _isRunning = false;
      _file = null;
      _controller.add(_isRunning);
    });
  }

  void toggle() {
    return (_isRunning) ? stop() : start();
  }

  void dispose() {
    for (final s in _sub) {
      s.cancel();
    }
  }
}
