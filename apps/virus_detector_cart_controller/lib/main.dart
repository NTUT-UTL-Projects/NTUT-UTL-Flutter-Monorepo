import 'dart:async';

import 'package:bluetooth_presentation/bluetooth_presentation.dart';
import 'package:bluetooth_utils/bluetooth_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;
import 'package:provider/provider.dart';
import 'package:virus_detector_cart_controller/presentation/view/move_controller_view/move_controller_view.dart';
import 'package:virus_detector_cart_controller/presentation/view/valve_controller_view/valve_controller_view.dart';

import 'init/initializer.dart';
import 'presentation/screen/home_page.dart';
import 'presentation/view/bluetooth_devices_scanner/bluetooth_devices_scanner.dart';

late final Initializer initializer;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Flutter Blue Plus
  bool fbpIsSupported;
  try {
    fbpIsSupported = await fbp.FlutterBluePlus.isSupported;
  } catch (e) {
    fbpIsSupported = false;
  }
  initializer = Initializer(fbpIsSupported: fbpIsSupported);
  await initializer();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final homePage = HomePage();
    final bluetoothOffPage = BluetoothStatusView();
    return MaterialApp(
      title: "Main",
      theme: ThemeData.light(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        extensions: [
          // Bluetooth
          BluetoothDeviceTileTheme(
            connectedColor: Colors.blue,
            connectedIcon: Icons.bluetooth_connected,
            disconnectedColor: Colors.red,
            disconnectedIcon: Icons.bluetooth_disabled,
            highlightColor: Colors.black,
            nullRssiIcon: Icons.device_unknown,
            selectedColor: Colors.green,
          ),
          BluetoothStatusTheme(backGroundColor: Colors.blue),
        ],
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
        extensions: [
          // Bluetooth
          BluetoothDeviceTileTheme(
            connectedColor: Colors.indigoAccent,
            connectedIcon: Icons.bluetooth_connected,
            disconnectedColor: Colors.red[700]!,
            disconnectedIcon: Icons.bluetooth_disabled,
            highlightColor: Colors.white,
            nullRssiIcon: Icons.device_unknown,
            selectedColor: Colors.green[700]!,
          ),
          BluetoothStatusTheme(backGroundColor: Colors.indigoAccent),
        ],
      ),
      themeMode: ThemeMode.system,
      home: MultiProvider(
        providers: [
          // Bluetooth
          StreamProvider(
            create: (_) => (initializer.fbpIsSupported)
                ? fbp.FlutterBluePlus.adapterState
                : null,
            initialData: (initializer.fbpIsSupported)
                ? fbp.FlutterBluePlus.adapterStateNow
                : fbp.BluetoothAdapterState.on,
          ),
          Provider<BluetoothStatusController>(
            create: (_) => BluetoothStatusController(
              onPressedButton: () => fbp.FlutterBluePlus.turnOn(),
            ),
          ),
          ChangeNotifierProvider<BluetoothDevicesScannerController>(
            create: (_) => BluetoothDevicesScannerController(
              fbpIsSupported: initializer.fbpIsSupported,
              fbpSystemDevices: initializer.fbpSystemDevices,
            ),
          ),

          // Domains
          ChangeNotifierProvider(
            create: (_) => MoveController(
              trigger: (point) async {
                for (final device in fbp.FlutterBluePlus.connectedDevices) {
                  for (final s in device.servicesList) {
                    for (final c in s.characteristics.where((c) {
                      final p = c.properties;
                      return p.write || p.writeWithoutResponse;
                    })) {
                      try {
                        // TODO
                        // point to bytes.
                        await c.write([]);
                      } catch (e) {}
                    }
                  }
                }
              },
            ),
          ),
          ChangeNotifierProvider(
            create: (_) => ValveController(
              trigger: (valve) async {
                for (final device in fbp.FlutterBluePlus.connectedDevices) {
                  for (final s in device.servicesList) {
                    for (final c in s.characteristics.where((c) {
                      final p = c.properties;
                      return p.write || p.writeWithoutResponse;
                    })) {
                      try {
                        // TODO
                        // valve to bytes.
                        await c.write([]);
                      } catch (e) {}
                    }
                  }
                }
              },
            ),
          ),
        ],
        builder: (context, _) {
          return (context.watch<fbp.BluetoothAdapterState>() ==
                  fbp.BluetoothAdapterState.on)
              ? homePage
              : bluetoothOffPage;
        },
      ),
      navigatorObservers: [BluetoothAdapterStateObserver()],
    );
  }
}
