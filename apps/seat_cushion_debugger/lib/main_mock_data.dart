import 'dart:async';

import 'package:flutter/material.dart';
import 'package:seat_cushion/infrastructure/repository/in_memory.dart';
import 'package:seat_cushion/infrastructure/sensor/decoder_mock_sensor.dart';
import 'package:seat_cushion/infrastructure/sensor_decoder/wei_zhe_decoder.dart';

import 'init/initializer.dart';
import 'main.dart';

final decoder = WeiZheDecoder();
late Timer timer;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Flutter Blue Plus
  final fbpIsSupported = false;
  initializer = Initializer(
    fbpIsSupported: fbpIsSupported,
    repository: InMemorySeatCushionRepository(),
    sensor: DecoderMockSeatCushionSensor(decoder: decoder),
  );
  await initializer();
  timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
    decoder.addValues(decoder.generateMokeValues());
  });
  runApp(MyApp());
}
