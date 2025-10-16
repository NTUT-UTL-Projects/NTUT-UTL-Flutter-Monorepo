import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'init/initializer.dart';
import 'main.dart';

late Timer timer;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Flutter Blue Plus
  final fbpIsSupported = false;
  initializer = Initializer(fbpIsSupported: fbpIsSupported);
  await initializer();
  sensor = Sensor(fbpIsSupported: fbpIsSupported);
  autoWrite = AutoWrite(sensor: sensor);
  int counter = 0;
  timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
    final bytes = ByteData(4)
      ..setFloat32(0, Random.secure().nextDouble() * 100, Endian.little);
    sensor.addMock([
      ((counter++) / 100.0).toInt(),
      ...bytes.buffer.asUint8List(),
    ]);
  });
  runApp(MyApp());
}
