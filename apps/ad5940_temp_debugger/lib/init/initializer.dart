import 'dart:async';

import 'package:bluetooth_utils/bluetooth_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;

class Initializer {
  final bool fbpIsSupported;
  final List<StreamSubscription> _sub = [];
  late final List<fbp.BluetoothDevice> fbpSystemDevices;
  late final Timer updateRssi;

  Initializer({required this.fbpIsSupported});

  Future call() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Flutter Blue Plus
    if (fbpIsSupported) {
      await fbp.FlutterBluePlus.setLogLevel(fbp.LogLevel.none, color: true);
      await BondFlutterBluePlus.init();
      CharacteristicFlutterBluePlus.init();
      DescriptorFlutterBluePlus.init();
      RssiFlutterBluePlus.init();
      ScanResultFlutterBluePlus.init();
      fbpSystemDevices = await fbp.FlutterBluePlus.systemDevices([]);
      updateRssi = Timer.periodic(const Duration(milliseconds: 100), (_) async {
        for (final d in fbp.FlutterBluePlus.connectedDevices) {
          try {
            await d.readRssi();
          } catch (e) {}
        }
      });
      // Auto setNotifyValue while a new [fbp.BluetoothDevice] get connected.
      _sub.add(
        ConnectionStateFlutterBluePlus.onConnectionStateChanged.listen((
          device,
        ) async {
          final services = await device.discoverServices();
          for (final s in services) {
            for (final c in s.characteristics) {
              final properties = c.properties;
              if (properties.indicate ||
                  properties.indicateEncryptionRequired ||
                  properties.notify ||
                  properties.notifyEncryptionRequired) {
                try {
                  c.setNotifyValue(true);
                } catch (e) {}
              }
            }
          }
        }),
      );
    } else {
      fbpSystemDevices = [];
    }
    return;
  }
}
