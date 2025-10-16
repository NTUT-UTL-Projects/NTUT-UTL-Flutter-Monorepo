import 'package:bluetooth_presentation/bluetooth_presentation.dart';
import 'package:bluetooth_utils/bluetooth_utils.dart';
import 'package:data_utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:seat_cushion/infrastructure/repository/in_memory.dart';
import 'package:seat_cushion/infrastructure/sensor/bluetooth_sensor.dart';
import 'package:seat_cushion/infrastructure/sensor_decoder/wei_zhe_decoder.dart';
import 'package:seat_cushion_presentation/seat_cushion_presentation.dart';

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
  } catch (e) {
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
          BluetoothCommandLineTheme(
            clearColor: Colors.red,
            clearIcon: Icons.delete,
            initColor: Colors.blue,
            initIcon: Icons.start,
            sendColor: Colors.orange,
            sendIcon: Icons.send,
          ),

          // Domain
          SeatCushionForceWidgetTheme(
            borderColor: Colors.black,
            forceToColor: weiZheForceToColorConverter,
          ),
          SeatCushionIschiumPointWidgetTheme(
            borderColor: Colors.black,
            ischiumColor: Colors.pinkAccent,
          ),
          home.AllSeatCushionForces3DMeshWidgetTheme(
            baseColor: Colors.black,
            forceScale: 0.05,
            forceToColor: weiZheForceToColorConverter,
            strokeColor: Colors.black,
          ),
          SeatCushionFeaturesLineTheme(
            clearColor: Colors.red,
            clearIcon: Icons.delete,
            downloadColor: Colors.green,
            downloadIcon: Icons.file_download,
            recordColor: Colors.orange,
            recordIcon: Icons.save,
          ),
          SeatCushionForceColorBarTheme(
            forceToColor: weiZheForceToColorConverter,
          ),
          home.HomePageTheme(
            bluetoothScannerIcon: Icons.bluetooth_searching_rounded,
            seatCushion3DMeshIcon: Icons.curtains_sharp,
            seatCushionDashboardIcon: Icons.map,
          ),
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
          BluetoothCommandLineTheme(
            clearColor: Colors.red[700]!,
            clearIcon: Icons.delete,
            initColor: Colors.indigoAccent,
            initIcon: Icons.start,
            sendColor: Colors.orange[700]!,
            sendIcon: Icons.send,
          ),

          // Domain
          SeatCushionForceWidgetTheme(
            borderColor: Colors.white,
            forceToColor: weiZheForceToColorConverter,
          ),
          SeatCushionIschiumPointWidgetTheme(
            borderColor: Colors.white,
            ischiumColor: Colors.pinkAccent[700]!,
          ),
          home.AllSeatCushionForces3DMeshWidgetTheme(
            baseColor: Colors.white,
            forceScale: 0.05,
            forceToColor: weiZheForceToColorConverter,
            strokeColor: Colors.white,
          ),
          SeatCushionFeaturesLineTheme(
            clearColor: Colors.red[700]!,
            clearIcon: Icons.delete,
            downloadColor: Colors.green[700]!,
            downloadIcon: Icons.file_download,
            recordColor: Colors.orange[700]!,
            recordIcon: Icons.save,
          ),
          SeatCushionForceColorBarTheme(
            forceToColor: weiZheForceToColorConverter,
          ),
          home.HomePageTheme(
            bluetoothScannerIcon: Icons.bluetooth_searching_rounded,
            seatCushion3DMeshIcon: Icons.curtains_sharp,
            seatCushionDashboardIcon: Icons.map,
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
          ChangeNotifierProvider(
            create: (_) => BluetoothCommandLineController(
              sendPacket: (controller) async {
                for (final device in fbp.FlutterBluePlus.connectedDevices) {
                  for (final s in device.servicesList) {
                    for (final c in s.characteristics.where((c) {
                      final p = c.properties;
                      return p.write || p.writeWithoutResponse;
                    })) {
                      try {
                        await c.write(controller.text.hexToBytes());
                      } catch (e) {}
                    }
                  }
                }
              },
              triggerInit: () {},
            ),
          ),

          // Domain
          StreamProvider(
            create: (_) => initializer.sensor.leftStream,
            initialData: null,
          ),
          StreamProvider(
            create: (_) => initializer.sensor.rightStream,
            initialData: null,
          ),
          StreamProvider(
            create: (_) => initializer.sensor.setStream,
            initialData: null,
          ),
          ChangeNotifierProvider(
            create: (_) => SeatCushionFeaturesLineController(
              downloadFile: (appLocalizations) async {
                final file = await SeatCushionFile.createSeatCushionFile();
                await file.writeHead();
                await for (var entity
                    in initializer.repository.fetchEntities()) {
                  await file.writeSeatCushionEntity(entity);
                }
                await file.writeTail();
                await Fluttertoast.showToast(
                  msg: appLocalizations.downloadFileFinishedNotification(
                    "json",
                  ),
                );
              },
              isClearing: initializer.repository.isClearingAllEntities,
              isClearingStream:
                  initializer.repository.isClearingAllEntitiesStream,
              isRecording: initializer.sensorRecoderController.isRecording,
              isRecordingStream:
                  initializer.sensorRecoderController.isRecordingStream,
              triggerClear: (appLocalizations) async {
                await initializer.repository.clearAllEntities();
                String message;
                switch (appLocalizations.localeName) {
                  case "zh":
                    message = "清除旧数据。";
                  case "zh_TW":
                    message = "清除舊數據。";
                  default:
                    message = "Clear old data.";
                }
                await Fluttertoast.showToast(msg: message);
              },
              triggerRecord: () =>
                  initializer.sensorRecoderController.isRecording =
                      !initializer.sensorRecoderController.isRecording,
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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorObservers: [BluetoothAdapterStateObserver()],
    );
  }
}
