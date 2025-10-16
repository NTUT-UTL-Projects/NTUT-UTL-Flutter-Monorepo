import 'dart:async';
import 'package:bluetooth_presentation/bluetooth_presentation.dart';
import 'package:bluetooth_utils/bluetooth_utils.dart';
import 'package:data_presentation/data_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'application/write_bluetooth_packet_file.dart';
import 'assets/bluetooth_icons_icons.dart' as asset;
import 'presentation/dto/bluetooth_devices_filter.dart';
import 'presentation/screen/home_page/home_page.dart';

late final WriteBluetoothPacketFile writeBluetoothPacketFile;

late final bool fbpIsSupported;
var fbpSystemDevices = <fbp.BluetoothDevice>[];
late final Timer updateRssi;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Flutter Blue Plus
  try {
    fbpIsSupported = await fbp.FlutterBluePlus.isSupported;
  } catch (e) {
    fbpIsSupported = false;
  }
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
  }
  writeBluetoothPacketFile = WriteBluetoothPacketFile(
    fbpIsSupported: fbpIsSupported,
    fileNameCreator: (time) {
      return "Bluetooth_Debugger_${time
        .toString()
        .replaceAll(" ", "_")
        .replaceAll(":", "-")
        .replaceAll(".", "-")
      }";
    },
  );
  return;
}

Future<void> main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final homePage = MultiProvider(
      providers: [
        ChangeNotifierProvider<HomePageController>(
          create: (_) => HomePageController(
            fbpIsSupported: fbpIsSupported,
            fbpSystemDevices: fbpSystemDevices,
          ),
        ),
        Provider<WriteBluetoothPacketFile>(
          create: (_) => writeBluetoothPacketFile,
        ),
      ],
      child: HomePage(),
    );

    final bluetoothOffPage = Provider<BluetoothStatusController>(
      create: (_) => BluetoothStatusController(
        onPressedButton: () async {
          for (final permission in bluetoothPermissions) {
            if (!(await permission.request()).isGranted) {
              return;
            }
          }
          try {
            await fbp.FlutterBluePlus.turnOn();
          } catch (e) {}
        },
      ),
      child: BluetoothStatusView(),
    );

    return MaterialApp(
      title: 'Bluetooth Debugger',
      theme: ThemeData.light(
        useMaterial3: true,
      ).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        extensions: [
          // Bluetooth Scanner
          BluetoothDeviceTileTheme(
            classicIcon: asset.BluetoothIcons.classic,
            connectedColor: Colors.blue,
            connectedIcon: asset.BluetoothIcons.connected,
            disconnectedColor: Colors.red,
            disconnectedIcon: asset.BluetoothIcons.disconnected,
            highlightColor: Colors.black,
            highSpeedIcon: asset.BluetoothIcons.high_speed,
            inSystemIcon: asset.BluetoothIcons.system,
            lowPowerIcon: asset.BluetoothIcons.low_power,
            nullRssiIcon: asset.BluetoothIcons.null_rssi,
            pairedIcon: asset.BluetoothIcons.paired,
            selectedColor: Colors.green,
            typeIconColor: Colors.orange,
            unpairedIcon: asset.BluetoothIcons.unpaired,
          ),

          // Bluetooth Status
          BluetoothStatusTheme(
            backGroundColor: Colors.blue,
          ),

          // Flutter Blue Pluse Tile
          ServiceTileTheme(
            titleColor: Colors.blue,
          ),
          CharacteristicTileTheme(
            titleColor: Colors.green,
          ),
          DescriptorTileTheme(
            titleColor: Colors.orange,
          ),
          BytesTheme(
            colorCycle: [Colors.red, Colors.green],
            indexColor: Colors.grey,
          ),

          // Home
          HomePageTheme(
            appBarBackgroundColor: Colors.white,
            filterToIcon: (filter) {
              switch (filter) {
                case BluetoothDevicesFilter.inSystem:
                  return asset.BluetoothIcons.system;
                case BluetoothDevicesFilter.nameIsNotEmpty:
                  return asset.BluetoothIcons.name;
                case BluetoothDevicesFilter.isConnected:
                  return asset.BluetoothIcons.connected;
                case BluetoothDevicesFilter.isConnectable:
                  return asset.BluetoothIcons.connectable;
              }
            },
            highlightColor: Colors.black,
            startTaskColor: Colors.green,
            stopTaskColor: Colors.red,
            timestampColor: Colors.grey,
            toggleFilterColor: Colors.orange,
          ),
        ],
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigoAccent,
        ),
        extensions: [
          // Bluetooth Scanner
          BluetoothDeviceTileTheme(
            classicIcon: asset.BluetoothIcons.classic,
            connectedColor: Colors.indigoAccent,
            connectedIcon: asset.BluetoothIcons.connected,
            disconnectedColor: Colors.red[700]!,
            disconnectedIcon: asset.BluetoothIcons.disconnected,
            highlightColor: Colors.white,
            highSpeedIcon: asset.BluetoothIcons.high_speed,
            inSystemIcon: asset.BluetoothIcons.system,
            lowPowerIcon: asset.BluetoothIcons.low_power,
            nullRssiIcon: asset.BluetoothIcons.null_rssi,
            pairedIcon: asset.BluetoothIcons.paired,
            selectedColor: Colors.green[700]!,
            typeIconColor: Colors.orange[700]!,
            unpairedIcon: asset.BluetoothIcons.unpaired,
          ),

          // Bluetooth Status
          BluetoothStatusTheme(
            backGroundColor: Colors.indigoAccent,
          ),

          // Flutter Blue Pluse Tile
          ServiceTileTheme(
            titleColor: Colors.indigoAccent,
          ),
          CharacteristicTileTheme(
            titleColor: Colors.green[700]!,
          ),
          DescriptorTileTheme(
            titleColor: Colors.orange[700]!,
          ),
          BytesTheme(
            colorCycle: [Colors.red[700]!, Colors.green[700]!],
            indexColor: Colors.grey,
          ),

          // Home
          HomePageTheme(
            appBarBackgroundColor: Colors.black,
            filterToIcon: (filter) {
              switch (filter) {
                case BluetoothDevicesFilter.inSystem:
                  return asset.BluetoothIcons.system;
                case BluetoothDevicesFilter.nameIsNotEmpty:
                  return asset.BluetoothIcons.name;
                case BluetoothDevicesFilter.isConnected:
                  return asset.BluetoothIcons.connected;
                case BluetoothDevicesFilter.isConnectable:
                  return asset.BluetoothIcons.connectable;
              }
            },
            highlightColor: Colors.white,
            startTaskColor: Colors.green[700]!,
            stopTaskColor: Colors.red[700]!,
            timestampColor: Colors.grey,
            toggleFilterColor: Colors.orange[700]!,
          ),
        ],
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: StreamProvider(
        create: (_) => (fbpIsSupported)
          ? fbp.FlutterBluePlus.adapterState
          : null,
        initialData: (fbpIsSupported)
            ? fbp.FlutterBluePlus.adapterStateNow
            : BluetoothAdapterState.on,
        builder: (context, _) {
          return (context.watch<fbp.BluetoothAdapterState>() ==
                  fbp.BluetoothAdapterState.on)
              ? homePage
              : bluetoothOffPage;
        },
      ),
      navigatorObservers: [
        BluetoothAdapterStateObserver(),
      ],
    );
  }
}
