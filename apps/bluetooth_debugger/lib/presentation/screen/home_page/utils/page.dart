part of '../home_page.dart';

class BluetoothDeviceTileTheme extends BluetoothDeviceDetailsTileTheme {
  BluetoothDeviceTileTheme({
    required super.classicIcon,
    required super.connectedColor,
    required super.connectedIcon,
    required super.disconnectedColor,
    required super.disconnectedIcon,
    required super.highlightColor,
    required super.highSpeedIcon,
    required super.inSystemIcon,
    required super.lowPowerIcon,
    required super.nullRssiIcon,
    required super.pairedIcon,
    required super.selectedColor,
    required super.typeIconColor,
    required super.unpairedIcon,
  });
}

/// **References**
///
/// **Requirements:**
/// - [BluetoothDevicesFilterController]
/// - [HomePageController]
/// - [WriteBluetoothPacketFile]
///
/// **Theme**
/// - [HomePageTheme]
/// - [BluetoothDeviceTileTheme]
/// - [ServiceTileTheme]
/// - [CharacteristicTileTheme]
/// - [DescriptorTileTheme]
/// - [BytesTheme]
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final toggleWriteFileButton = Builder(
      builder: (context) {
        final app = context.read<WriteBluetoothPacketFile>();
        final stream = app.isRunningStream;
        final body = Builder(
          builder: (context) {
            final themeData = Theme.of(context);
            final themeExtension = themeData.extension<HomePageTheme>();
            final isRunning = context.watch<bool>();
            VoidCallback? onPressed = app.toggle;
            final icon = (isRunning)
              ? Icon(Icons.stop)
              : Icon(Icons.save);
            final color = (isRunning)
                ? themeExtension?.stopTaskColor
                : themeExtension?.startTaskColor;
            return IconButton(
              onPressed: onPressed,
              icon: icon,
              color: color,
              highlightColor: themeExtension?.highlightColor,
            );
          },
        );
        return StreamProvider(
          create: (_) => stream,
          initialData: app.isRunning,
          child: body,
        );
      },
    );

    final filterList = BluetoothDevicesFilter.values.map((filter) {
      return Builder(
        builder: (context) {
          final check = context.select<HomePageController, bool>(
            (n) => n.chekcBluetoothDevicesFilter(filter),
          );
          final themeData = Theme.of(context);
          final themeExtension = themeData.extension<HomePageTheme>();
          final iconData = themeExtension?.filterToIcon(filter);
          final color = check
            ? themeExtension?.toggleFilterColor
            : null;
          return IconButton(
            onPressed: () => context
                .read<HomePageController>()
                .toggleBluetoothDevicesFilter(filter),
            icon: Icon(
              iconData,
            ),
            color: color,
            highlightColor: themeExtension?.highlightColor,
          );
        },
      );
    }).toList();

    final bytesView = Builder(
      builder: (BuildContext context) {
        final bytes = context.watch<List<int>?>();
        if (bytes == null) return Column();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            Builder(
              builder: (context) {
                final themeData = Theme.of(context);
                final themeExtension = themeData.extension<HomePageTheme>();
                return Text(
                  DateTime.now().toString(),
                  style: TextStyle(
                    fontSize: 13,
                    color: themeExtension?.timestampColor,
                  ),
                );
              },
            ),
            BytesView(bytes: bytes),
          ],
        );
      },
    );

    final writeField = Builder(
      builder: (context) {
        final controller = context.watch<_ValueEditingController>();
        return TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          inputFormatters: [
            HexFormatter(),
          ],
        );
      },
    );

    final deviceDetailView = Builder(
      builder: (context) {
        // Flutter Blue Plus
        final bluetoothDevice = context
            .select<HomePageController, BluetoothDevice?>(
              (c) => c.selectedDevice,
            );
        if (bluetoothDevice != null) {
          return MultiProvider(
            providers: [
              ProxyProvider(
                update: (_, _, _) => bluetoothDevice,
              ),
              ChangeNotifierProvider<_ValueEditingController>(
                create: (_) => _ValueEditingController(),
              ),
            ],
            child: Builder(
              builder: (context) {
                final controller = context.watch<_ValueEditingController>();
                return ProxyProvider<HomePageController, fbp.BluetoothDevice?>(
                  update: (context, controller, prev) =>
                      controller.fbpSelectedDevice,
                  child: Builder(
                    builder: (context) {
                      final device = context.watch<fbp.BluetoothDevice?>();
                      if (device == null) return Text("No device be selected.");
                      return DeviceView(
                        serviceTile: ServiceTile(
                          characteristicTile: CharacteristicTile(
                            descriptorTile: DescriptorTile(
                              writeValueGetter: () =>
                                  controller.text.hexToBytes(),
                              valueTile: bytesView,
                            ),
                            writeValueGetter: () =>
                                controller.text.hexToBytes(),
                            valueTile: bytesView,
                          ),
                        ),
                        writeField: writeField,
                      );
                    },
                  ),
                );
              },
            ),
          );
        }
        return Column();
      },
    );

    final scanner = Builder(
      builder: (context) {
        final controller = context.read<HomePageController>();
        return RefreshIndicator(
          onRefresh: () async {
            await controller.setScanning(true);
          },
          child: Builder(
            builder: (context) {
              return ProxyProvider<HomePageController, List<BluetoothDevice>>(
                update: (_, value, _) => value.devices,
                builder: (context, _) {
                  final length = context.select<List<BluetoothDevice>, int>(
                    (devices) => devices.length,
                  );
                  return ListView.builder(
                    itemCount: length,
                    itemBuilder: (context, index) {
                      return ProxyProvider<
                        List<BluetoothDevice>,
                        BluetoothDevice
                      >(
                        update: (_, devices, _) => devices.elementAt(index),
                        child: BluetoothDeviceDetailsTile(),
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );

    final body = LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (
              details.localPosition.dx < constraints.maxWidth * 0.5
              && details.primaryDelta! > 10
            ) {
              Scaffold.of(context).openDrawer();
            }
          },
          child: scanner,
        );
      },
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final themeData = Theme.of(context);
        final themeExtension = themeData.extension<HomePageTheme>();
        final appBar = AppBar(
          actions: filterList,
          automaticallyImplyLeading: false,
          backgroundColor: themeExtension?.appBarBackgroundColor,
          title: toggleWriteFileButton,
        );
        return Scaffold(
          appBar: appBar,
          drawer: Drawer(
            width: constraints.maxWidth * 0.80,
            child: deviceDetailView,
          ),
          body: body,
        );
      },
    );
  }
}
