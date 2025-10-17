import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bluetooth_presentation/bluetooth_presentation.dart';
import 'package:bluetooth_utils/bluetooth_utils.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:data_utils/data_utils.dart';
import 'package:electrochemical/electrochemical.dart';
import 'package:equatable/equatable.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;
import 'package:path_provider_utils/path_provider_utils.dart';
import 'package:provider/provider.dart';
import 'package:stream_utils/stream_util.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'init/initializer.dart';
import 'presentation/view/bluetooth_devices_scanner/bluetooth_devices_scanner.dart';
import 'presentation/widget/bluetooth_command_view/bluetooth_command_view.dart';

part 'main.g.dart';

@CopyWith()
class Data with EquatableMixin {
  final int id;
  final List<double> data;

  Data({required this.id, required this.data});

  Data addValue(double value) {
    return copyWith(data: [...data, value]);
  }

  @override
  List get props => [id, data];
}

class Sensor {
  static const max = 3;

  final bool fbpIsSupported;

  Sensor({required this.fbpIsSupported}) {
    _sub.add(
      valueStream.listen((values) async {
        final id = values.elementAt(0);
        var target = _dataList.where((d) => d.id == id).firstOrNull;
        if (target == null) {
          target = Data(id: id, data: []);
          _dataList.add(target);
        }
        Uint8List uint8List = Uint8List.fromList(values.skip(1).toList());
        ByteBuffer buffer = uint8List.buffer;
        Float32List float32List = Float32List.view(buffer);
        double newValue = float32List.elementAt(0);

        final updatedList = _dataList.map((d) {
          if (d.id == id) return d.addValue(newValue);
          return d;
        }).toList();

        if (updatedList.length > max) {
          updatedList.removeAt(0);
        }

        _dataList = updatedList;
        _dataController.add(_dataList);
      }),
    );
  }

  var _dataList = <Data>[];

  final _dataController = StreamController<List<Data>>.broadcast();

  final _mockController = StreamController<List<int>>.broadcast();

  final _sub = <StreamSubscription>[];

  Stream<List<Data>> get dataListStream => _dataController.stream;

  List<Data> get dataList => [..._dataList];

  Stream<List<int>> get valueStream => mergeStreams([
    _mockController.stream,
    if (fbpIsSupported)
      CharacteristicFlutterBluePlus.onCharacteristicReceived.map(
        (d) => d.lastReceivedValue,
      ),
  ]);

  void addMock(List<int> value) {
    _mockController.add(value);
  }

  void dispose() {
    _dataController.close();
    _mockController.close();
    for (final s in _sub) {
      s.cancel();
    }
  }
}

class AutoWrite {
  final Sensor sensor;
  final _files = <int, File>{};
  final _sub = <StreamSubscription>[];

  AutoWrite({required this.sensor}) {
    _sub.add(
      sensor.valueStream.listen((value) async {
        final id = value.elementAt(0);
        if (!_files.containsKey(id)) {
          final path = (await getSystemDownloadDirectory())?.absolute.path;
          _files.addEntries(
            {
              id: File("$path/ad5940_${DateTime.now().toFileFormat()}_$id.csv"),
            }.entries,
          );
        }
        final file = _files[id]!;
        Uint8List uint8List = Uint8List.fromList(value.skip(1).toList());
        ByteBuffer buffer = uint8List.buffer;
        Float32List float32List = Float32List.view(buffer);
        await file.writeAsString(
          "${float32List.elementAt(0).toString()}, ",
          mode: FileMode.append,
        );
      }),
    );
  }

  void dispose() {
    for (final s in _sub) {
      s.cancel();
    }
  }
}

late final Initializer initializer;
late final Sensor sensor;
late final AutoWrite autoWrite;

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
  sensor = Sensor(fbpIsSupported: fbpIsSupported);
  autoWrite = AutoWrite(sensor: sensor);
  runApp(MyApp());
}

class LineChartController extends ChangeNotifier {
  final Sensor sensor;

  LineChartController({required this.sensor}) {
    _sub.add(
      sensor.dataListStream.listen((_) {
        notifyListeners();
      }),
    );
  }
  final _sub = <StreamSubscription>[];

  List<Data> get dataList => sensor.dataList.toList();

  @override
  void dispose() {
    for (final s in _sub) {
      s.cancel();
    }
    super.dispose();
  }
}

class DpvLineChartController extends LineChartController {
  DpvLineChartController({required super.sensor});

  @override
  List<Data> get dataList => sensor.dataList
      .map((d) => d.copyWith.data(d.data.mapDpv.toList()))
      .toList();
}

class LineChart<T extends LineChartController> extends StatelessWidget {
  const LineChart({super.key});

  List<CartesianSeries> mapSeries(List<Data> dataList) {
    return dataList.indexed.map((e) {
      int length = dataList.length;
      int index = e.$1;
      var data = e.$2;
      return LineSeries<(int, double), double>(
        name: "${data.id}",
        dataSource: data.data.indexed.toList(),
        animationDuration: 0,
        xValueMapper: (data, _) => data.$1.toDouble(),
        yValueMapper: (data, _) => data.$2,
        color: HSVColor.fromAHSV(
          1.0,
          (index.toDouble() / length.toDouble()) * 360.0,
          1.0,
          1.0,
        ).toColor(),
        width: 1.5,
        // markerSettings: MarkerSettings(isVisible: true),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final data = context.select<T, List<Data>>((c) => c.dataList);
    // final data = context.watch<T>().dataList;
    return SfCartesianChart(
      series: mapSeries(data),
      trackballBehavior: TrackballBehavior(
        enable: true,
        shouldAlwaysShow: true,
        activationMode: ActivationMode.singleTap,
        tooltipAlignment: ChartAlignment.near,
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        // tooltipDisplayMode: TrackballDisplayMode.nearestPoint,
        // tooltipSettings: InteractiveTooltip(
        //   enable: true,
        // ),
        lineType: TrackballLineType.vertical,
      ),
      zoomPanBehavior: ZoomPanBehavior(
        enablePinching: true,
        // enableDoubleTapZooming: true,
        enablePanning: true,
        // zoomMode: ZoomMode.x,
        enableMouseWheelZooming: true,
      ),
    );
  }
}

/// **References:**
/// - [BluetoothDevicesScanner]
/// - [BluetoothCommandViewTheme]
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final tabViewMap = {
      "Bluetooth Scanner": BluetoothDevicesScanner(),
      "Bluetooth Command": BluetoothCommandView(),
      "Normal Line Chart": LineChart<LineChartController>(),
      "DPV Line Chart": LineChart<DpvLineChartController>(),
    };
    return DefaultTabController(
      length: tabViewMap.length,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: false,
          appBar: TabBar(
            isScrollable: false,
            tabs: tabViewMap.keys.map((text) {
              return Text(
                text,
                style: Theme.of(context).textTheme.titleLarge,
              );
            }).toList(),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: tabViewMap.values.toList(),
          ),
        ),
      ),
    );
  }
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
          BluetoothCommandViewTheme(
            clearColor: Colors.red,
            clearIcon: Icons.delete,
            initColor: Colors.blue,
            initIcon: Icons.start,
            sendColor: Colors.orange,
            sendIcon: Icons.send,
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
          BluetoothCommandViewTheme(
            clearColor: Colors.red[700]!,
            clearIcon: Icons.delete,
            initColor: Colors.indigoAccent,
            initIcon: Icons.start,
            sendColor: Colors.orange[700]!,
            sendIcon: Icons.send,
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
            create: (_) => BluetoothCommandViewController(
              sendPacket: (controller) async {
                for (final device in fbp.FlutterBluePlus.connectedDevices) {
                  for (final s in device.servicesList) {
                    for (final c in s.characteristics.where((c) {
                      final p = c.properties;
                      return p.write || p.writeWithoutResponse;
                    })) {
                      try {
                        for (final bytes
                            in controller.text
                                .split("\n")
                                .map((t) => t.hexToBytes())) {
                          await c.write(bytes);
                        }
                      } catch (e) {}
                    }
                  }
                }
              },
              triggerInit: () {},
            ),
          ),

          // Domains
          ChangeNotifierProvider(
            create: (_) => LineChartController(sensor: sensor),
          ),
          ChangeNotifierProvider(
            create: (_) => DpvLineChartController(sensor: sensor),
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
