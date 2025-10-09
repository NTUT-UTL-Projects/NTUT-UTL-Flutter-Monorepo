import 'dart:async';

import 'package:bluetooth_utils/utils/flutter_blue_plus_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;
import 'package:seat_cushion/seat_cushion.dart';

import '../application/seat_cushion_sensor_data_handler.dart';

class Initializer {
  final bool fbpIsSupported;
  final SeatCushionRepository repository;
  final SeatCushionSensor sensor;
  late final SeatCushionSensorRecorderController sensorRecoderController;
  late final List<fbp.BluetoothDevice> fbpSystemDevices;
  late final Timer updateRssi;

  Initializer({required this.fbpIsSupported, required this.repository, required this.sensor});

  Future call() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Flutter Blue Plus
    if(fbpIsSupported) {
      await fbp.FlutterBluePlus.setLogLevel(fbp.LogLevel.none, color: true);
      await BondFlutterBluePlus.init();
      CharacteristicFlutterBluePlus.init();
      DescriptorFlutterBluePlus.init();
      RssiFlutterBluePlus.init();
      ScanResultFlutterBluePlus.init();
      fbpSystemDevices = await fbp.FlutterBluePlus.systemDevices([]);
      updateRssi = Timer.periodic(
        const Duration(milliseconds: 100),
        (_) async {
          for(final d in fbp.FlutterBluePlus.connectedDevices) {
            try {
              await d.readRssi();
            } catch(e) {}
          }
        }
      );
    } else {
      fbpSystemDevices = [];
    }
    sensorRecoderController = SeatCushionSensorRecorderController(sensor: sensor, repository: repository);
    return;
  }
}
