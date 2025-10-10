import 'package:bluetooth_utils/persentation/tile/simple_connection/tile.dart';
import 'package:bluetooth_utils/persentation/view/bluetooth_status_view.dart';
import 'package:bluetooth_utils/utils/flutter_blue_plus_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:seat_cushion/infrastructure/color/wei_zhe_color.dart';
import 'package:seat_cushion/infrastructure/repository/in_memory.dart';
import 'package:seat_cushion/infrastructure/sensor/bluetooth_sensor.dart';
import 'package:seat_cushion/infrastructure/sensor_decoder/wei_zhe_decoder.dart';
import 'package:seat_cushion/seat_cushion.dart';
import 'package:seat_cushion/seat_cushion_presentation.dart';

import 'init/initializer.dart';
import 'l10n/gen_l10n/app_localizations.dart';
import 'presentation/screen/home_page/home_page.dart' as home;
import 'presentation/view/bluetooth_devices_scanner/bluetooth_devices_scanner.dart';
import 'presentation/widget/bluetooth_command_line/bluetooth_command_line.dart';
import 'presentation/widget/seat_cushion_features_line/seat_cushion_features_line.dart';
import 'presentation/widget/seat_cushion_force_color_bar/seat_cushion_force_color_bar.dart';
import 'utils/seat_cushion_file.dart';

late final Initializer initializer;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Flutter Blue Plus
  bool fbpIsSupported;
  try {
    fbpIsSupported = await fbp.FlutterBluePlus.isSupported;
  } catch(e) {
    fbpIsSupported = false;
  }
  initializer = Initializer(
    fbpIsSupported: fbpIsSupported,
    repository: InMemorySeatCushionRepository(),
    sensor: BluetoothSeatCushionSensor(
      decoder: WeiZheDecoder(),
      fbpIsSupported: fbpIsSupported,
    ),
  );
  await initializer();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final homePage = home.HomePage();
    final bluetoothOffPage = BluetoothStatusView();
    return MaterialApp(
      title: "Main",
      theme: ThemeData.light(
        useMaterial3: true,
      ).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        extensions: [
          // Bluetooth
          BluetoothDeviceTileTheme(
            selectedColor: Colors.green,
            connectedColor: Colors.blue,
            disconnectedColor: Colors.red,
            highlightColor: Colors.black,
          ),
          BluetoothStatusTheme.recommended().copyWith(
            backGroundColor: Colors.blue,
          ),
          BluetoothCommandLineTheme(
            clearIconColor: Colors.red,
            initIconColor: Colors.blue,
          ),

          // Domain
          SeatCushionForceWidgetTheme(
            borderColor: Colors.black,
          ),
          SeatCushionIschiumPointWidgetTheme(
            borderColor: Colors.black,
            ischiumColor: Colors.pinkAccent,
          ),
          SeatCushion3DMeshWidgetTheme(
            baseColor: Colors.black,
            strokeColor: Colors.black,
          ),
          SeatCushionFeaturesLineTheme(
            clearIconColor: Colors.red,
            downloadIconColor: Colors.green,
            recordIconColor: Colors.orange,
          ),
        ],
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
        extensions: [
          // Bluetooth
          BluetoothDeviceTileTheme(
            selectedColor: Colors.green[700]!,
            connectedColor: Colors.indigoAccent,
            disconnectedColor: Colors.red[700]!,
            highlightColor: Colors.white,
          ),
          BluetoothStatusTheme.recommended().copyWith(
            backGroundColor: Colors.indigoAccent,
          ),
          BluetoothCommandLineTheme(
            clearIconColor: Colors.red[700]!,
            initIconColor: Colors.indigoAccent,
          ),

          // Domain
          SeatCushionForceWidgetTheme(
            borderColor: Colors.white,
          ),
          SeatCushionIschiumPointWidgetTheme(
            borderColor: Colors.white,
            ischiumColor: Colors.pinkAccent[700]!,
          ),
          SeatCushion3DMeshWidgetTheme(
            baseColor: Colors.white,
            strokeColor: Colors.white,
          ),
          SeatCushionFeaturesLineTheme(
            clearIconColor: Colors.red[700]!,
            downloadIconColor: Colors.green[700]!,
            recordIconColor: Colors.orange[700]!,
          ),
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
          Provider<BluetoothStatus>(create: (_) => BluetoothStatus(
            onPressedButton: () => fbp.FlutterBluePlus.turnOn(),
          )),
          ChangeNotifierProvider<BluetoothDevicesScannerController>(create: (_) => BluetoothDevicesScannerController(
            fbpIsSupported: initializer.fbpIsSupported,
            fbpSystemDevices: initializer.fbpSystemDevices,
          )),
          Provider<BluetoothDeviceIcons>(create: (_) => BluetoothDeviceIcons(
            connected: Icons.bluetooth_connected,
            disconnected: Icons.bluetooth_disabled,
            nullRssi: Icons.device_unknown,
          )),
          Provider(create: (_) => BluetoothCommandLineIcons(
            clear: Icons.delete,
            init: Icons.start,
            send: Icons.send,
          )),
          ChangeNotifierProvider(create: (_) => BluetoothCommandLineController(
            sendPacket: (hexString) async {
              for(final device in fbp.FlutterBluePlus.connectedDevices) {
                for(final s in device.servicesList) {
                  for(final c in s.characteristics.where((c) {
                    final p = c.properties;
                    return p.write || p.writeWithoutResponse;
                  })) {
                    try {
                      await c.write(c.lastValue);
                    } catch(e) {}
                  }
                }
              }
            },
            triggerInit: () {},
          )),

          // Domain
          StreamProvider<SeatCushionSet?>(
            create: (_) => initializer.sensor.setStream,
            initialData: null,
          ),
          Provider(
            create: (_) => SeatCushionForceWidgetUI(
              forceToColor: weiZheForceToColorConverter,
            ),
          ),
          Provider(
            create: (_) => home.SeatCushionForces3DMeshWidgetUI(
              cameraHight: 1200.0,
              focusLength: 1500.0,
              focusScale: 0.05,
            ),
          ),
          Provider(
            create: (_) => home.HomePageIcons(
              bluetoothScanner: Icons.bluetooth_searching_rounded,
              seatCushion3DMesh: Icons.curtains_sharp,
              seatCushionDashboard: Icons.map,
            ),
          ),
          ChangeNotifierProvider(
            create: (_) => SeatCushionFeaturesLineController(
              downloadFile: (appLocalizations) async {
                final file = await SeatCushionFile.createSeatCushionFile();
                await file.writeHead();
                await for (var entity in initializer.repository.fetchEntities()) {
                  await file.writeSeatCushionEntity(entity);
                }
                await file.writeTail();
                await Fluttertoast.showToast(
                  msg: appLocalizations.downloadFileFinishedNotification("json"),
                );
              },
              isClearing: initializer.repository.isClearingAllEntities,
              isClearingStream: initializer.repository.isClearingAllEntitiesStream,
              isRecording: initializer.sensorRecoderController.isRecording,
              isRecordingStream: initializer.sensorRecoderController.isRecordingStream,
              triggerClear: (appLocalizations) async {
                await initializer.repository.clearAllEntities();
                String message;
                switch(appLocalizations.localeName) {
                  case "zh":
                    message = "清除旧数据。";
                  case "zh_TW":
                    message = "清除舊數據。";
                  default:
                    message = "Clear old data.";
                }
                await Fluttertoast.showToast(
                  msg: message,
                );
              },
              triggerRecord: () => initializer.sensorRecoderController.isRecording = !initializer.sensorRecoderController.isRecording,
            ),
          ),
          Provider(
            create: (_) => SeatCushionFeaturesLineIcons(
              clear: Icons.delete,
              download: Icons.file_download,
              record: Icons.save,
            ),
          ),
          Provider(
            create: (_) => SeatCushionForceColorBarController(
              forceToColor: weiZheForceToColorConverter,
            ),
          ),
        ],
        builder: (context, _) {
          return (context.watch<fbp.BluetoothAdapterState>() == fbp.BluetoothAdapterState.on) 
            ? homePage
            : bluetoothOffPage;
        },
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorObservers: [
        BluetoothAdapterStateObserver(),
      ],
    );
  }
}