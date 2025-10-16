library;

import 'dart:async';

import 'package:bluetooth_utils/bluetooth_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'device_view.tailor.dart';
part 'tile/characteristic_tile.dart';
part 'tile/descriptor_tile.dart';
part 'tile/service_tile.dart';

class _CancelConnectionController extends ValueNotifier<bool> {
  final List<StreamSubscription> _sub = [];
  _CancelConnectionController(BluetoothDevice device) : super(false) {
    _sub.addAll([
      ConnectionStateFlutterBluePlus.onConnectionStateChanged
          .where((d) => d == device)
          .where((d) => d.isConnected)
          .listen((d) {
            value = false;
          }),
    ]);
  }

  @mustCallSuper
  @override
  void dispose() {
    for (final s in _sub) {
      s.cancel();
    }
    super.dispose();
  }
}

class _LoadingDiscoveringController extends ValueNotifier<bool> {
  final List<StreamSubscription> _sub = [];
  _LoadingDiscoveringController(BluetoothDevice device) : super(false) {
    _sub.addAll([
      ConnectionStateFlutterBluePlus.onConnectionStateChanged
          .where((d) => d == device)
          .listen((d) {
            value = false;
          }),
      BluetoothServicesFlutterBluePlus.onServicesChanged
          .where((d) => d == device)
          .listen((d) {
            value = false;
          }),
    ]);
  }

  @mustCallSuper
  @override
  void dispose() {
    for (final s in _sub) {
      s.cancel();
    }
    super.dispose();
  }
}

/// **Requirements:**
/// - [BluetoothDevice]
///
/// **Themes:**
/// - [TextTheme]
class DeviceView extends StatelessWidget {
  /// It provide the [BluetoothService].
  final Widget? serviceTile;

  final Widget? writeField;

  const DeviceView({
    super.key,
    this.serviceTile,
    this.writeField,
  });

  @override
  Widget build(BuildContext context) {
    final nameText = Builder(
      builder: (context) {
        final name = context.select<BluetoothDevice, String>(
          (d) => d.platformName,
        );
        return Text(
          name, 
          style: Theme.of(context).textTheme.titleLarge,
        );
      },
    );
    final connectionButton = Builder(
      builder: (context) {
        final device = context.watch<BluetoothDevice>();
        return MultiProvider(
          providers: [
            StreamProvider(
              create: (_) => device.connectionState,
              initialData: device.isConnected
                  ? BluetoothConnectionState.connected
                  : BluetoothConnectionState.disconnected,
            ),
            ChangeNotifierProvider(
              create: (_) => _CancelConnectionController(device),
            ),
          ],
          builder: (context, _) {
            final state = context.watch<BluetoothConnectionState>();
            final cancelController = context
                .watch<_CancelConnectionController>();
            final isConnected = state == BluetoothConnectionState.connected;
            if (isConnected) {
              return TextButton(
                onPressed: () async {
                  try {
                    await device.disconnect(queue: true);
                  } catch (e) {}
                },
                child: Text("DISCONNECT"),
              );
            } else {
              if (cancelController.value) {
                final spinner = Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black12,
                      color: Colors.black26,
                    ),
                  ),
                );
                final cancelButton = TextButton(
                  onPressed: () async {
                    cancelController.value = false;
                    try {
                      await device.disconnect(queue: false);
                    } catch (e) {}
                  },
                  child: Text(
                    "CANCEL",
                  ),
                );
                return Row(
                  children: [
                    spinner,
                    cancelButton,
                  ],
                );
              } else {
                return TextButton(
                  onPressed: () async {
                    cancelController.value = true;
                    try {
                      await device.connect(
                        license: License.free,
                        autoConnect: true,
                        mtu: null,
                      );
                    } catch (e) {}
                  },
                  child: Text(
                    "CONNECT",
                  ),
                );
              }
            }
          },
        );
      },
    );
    final idTile = Builder(
      builder: (context) {
        final remoteId = context.select<BluetoothDevice, String>(
          (d) => d.remoteId.str,
        );
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(remoteId),
        );
      },
    );
    final statusTile = Builder(
      builder: (context) {
        final device = context.watch<BluetoothDevice>();
        final icon = Builder(
          builder: (context) {
            return StreamProvider(
              create: (_) => device.connectionState,
              initialData: device.isConnected
                  ? BluetoothConnectionState.connected
                  : BluetoothConnectionState.disconnected,
              builder: (context, _) {
                final state = context.watch<BluetoothConnectionState>();
                final isConnected = state == BluetoothConnectionState.connected;
                final iconData = (isConnected)
                    ? Icons.bluetooth_connected
                    : Icons.bluetooth_disabled;
                return Icon(
                  iconData,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                );
              },
            );
          },
        );
        final rssi = Builder(
          builder: (context) {
            return StreamProvider(
              create: (_) => device.onAllRssi,
              initialData: device.rssi,
              builder: (context, _) {
                final rssi = context.watch<int?>();
                return Text(
                  '${(rssi != null) ? rssi.toString() : ""} dBm',
                  style: Theme.of(context).textTheme.bodySmall,
                );
              },
            );
          },
        );
        final title = Builder(
          builder: (context) {
            return StreamProvider(
              create: (_) => device.connectionState,
              initialData: device.isConnected
                  ? BluetoothConnectionState.connected
                  : BluetoothConnectionState.disconnected,
              builder: (context, _) {
                final state = context.watch<BluetoothConnectionState>();
                return Text(
                  'Device is ${state.name}.',
                  style: Theme.of(context).textTheme.bodySmall,
                );
              },
            );
          },
        );
        final discover = Builder(
          builder: (context) {
            return MultiProvider(
              providers: [
                StreamProvider(
                  create: (_) => device.connectionState,
                  initialData: device.isConnected
                      ? BluetoothConnectionState.connected
                      : BluetoothConnectionState.disconnected,
                ),
                StreamProvider(
                  create: (_) => device.onServicesChanged,
                  initialData: device.servicesList,
                ),
                ChangeNotifierProvider(
                  create: (_) => _LoadingDiscoveringController(device),
                ),
              ],
              builder: (context, _) {
                final loadingController = context
                    .watch<_LoadingDiscoveringController>();
                final isConnected =
                    context.watch<BluetoothConnectionState>() ==
                    BluetoothConnectionState.connected;

                /// Listens to [BluetoothService] changes to refresh the button state.
                context.watch<List<BluetoothService>>();

                final device = context.watch<BluetoothDevice>();
                if (loadingController.value) {
                  return const IconButton(
                    icon: SizedBox(
                      width: 18.0,
                      height: 18.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.grey),
                      ),
                    ),
                    onPressed: null,
                  );
                } else {
                  return TextButton(
                    onPressed: isConnected
                        ? () async {
                            loadingController.value = true;
                            try {
                              await device.discoverServices();
                            } catch (e) {}
                          }
                        : null,
                    child: const Text("Get Services"),
                  );
                }
              },
            );
          },
        );
        return ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              rssi,
            ],
          ),
          title: title,
          trailing: discover,
        );
      },
    );
    final mtuTile = Builder(
      builder: (context) {
        String mtuText = "";
        final device = context.watch<BluetoothDevice>();
        return ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Builder(
                builder: (context) {
                  final theme = Theme.of(context);
                  return Text(
                    'MTU Size',
                    style: theme.textTheme.titleSmall,
                  );
                },
              ),
              StreamProvider(
                create: (_) => device.mtu,
                initialData: device.mtuNow,
                builder: (context, _) {
                  final theme = Theme.of(context);
                  final mtu = context.watch<int>();
                  return Text(
                    '$mtu bytes',
                    style: theme.textTheme.bodySmall,
                  );
                },
              ),
            ],
          ),
          title: Builder(
            builder: (context) {
              return TextField(
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (s) => mtuText = s,
                onSubmitted: (_) async {
                  final mtu = int.tryParse(mtuText);
                  if (mtu == null) return;
                  try {
                    await device.requestMtu(mtu);
                  } catch (e) {}
                },
              );
            },
          ),
          trailing: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  final mtu = int.tryParse(mtuText);
                  if (mtu == null) return;
                  try {
                    await device.requestMtu(mtu);
                  } catch (e) {}
                },
              );
            },
          ),
        );
      },
    );
    final writeTile = Builder(
      builder: (context) {
        if (writeField == null) return Column();
        return ListTile(
          title: writeField,
        );
      },
    );
    final servicesList = Builder(
      builder: (context) {
        final device = context.watch<BluetoothDevice>();
        return StreamProvider(
          create: (_) => device.onServicesChanged,
          initialData: device.servicesList,
          child: Builder(
            builder: (context) {
              final length = context.select<List<BluetoothService>, int>(
                (services) => services.length,
              );
              return Column(
                children: List.generate(
                  length,
                  (index) {
                    return ProxyProvider<
                      List<BluetoothService>,
                      BluetoothService
                    >(
                      update: (_, services, __) => services.elementAt(index),
                      child: serviceTile,
                    );
                  }),
              );
            },
          ),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: nameText,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          connectionButton,
        ],
      ),
      body: Column(
        children: [
          idTile,
          statusTile,
          mtuTile,
          writeTile,
          Expanded(
            child: SingleChildScrollView(
              child: servicesList,
            ),
          ),
        ],
      ),
    );
  }
}
