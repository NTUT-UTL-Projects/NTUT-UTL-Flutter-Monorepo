library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/flutter_blue_plus_utils.dart';

part 'tile/characteristic_tile.dart';
part 'tile/descriptor_tile.dart';
part 'tile/service_tile.dart';

class DeviceView extends StatelessWidget {
  final ValueNotifier cancelConnectionNotifier = ValueNotifier<bool>(false);
  final ValueNotifier loadingDiscoveringNotifier = ValueNotifier<bool>(false);
  final Widget? serviceTile;
  final Widget? writeField;
  DeviceView({
    super.key,
    this.serviceTile,
    this.writeField,
  });
  @override
  Widget build(BuildContext context) {
    final nameText = Builder(
      builder: (context) {
        final name = context.select<BluetoothDevice, String>((d) => d.platformName);
        return Text(
          name, 
          style: Theme.of(context).listTileTheme.titleTextStyle,
        );
      },
    );
    final connectionButton = Builder(
      builder: (context) {
        final device = context.watch<BluetoothDevice>();
        return StreamProvider(
          create: (_) => device.connectionState,
          initialData: device.isConnected
            ? BluetoothConnectionState.connected
            : BluetoothConnectionState.disconnected,
          builder: (context, _) {
            final state = context.watch<BluetoothConnectionState>();
            final isConnected = state == BluetoothConnectionState.connected;
            if(state == BluetoothConnectionState.connected) {
              cancelConnectionNotifier.value = false;
            }
            if(isConnected) {
              return TextButton(
                onPressed: () async {
                  cancelConnectionNotifier.value = false;
                  try {
                    await device.disconnect(queue: true);
                  } catch(e) {}
                },
                child: Text(
                  "DISCONNECT",
                ),
              );
            } else {
              return ValueListenableBuilder(
                valueListenable: cancelConnectionNotifier,
                builder: (context, cancel, child) {
                  if(cancel) {
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
                        cancelConnectionNotifier.value = false;
                        try {
                          await device.disconnect(queue: false);
                        } catch(e) {}
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
                        cancelConnectionNotifier.value = true;
                        try {
                          await device.connect(
                            license: License.free,
                            autoConnect: true,
                            mtu: null,
                          );
                        } catch(e) {
                          cancelConnectionNotifier.value = false;
                        }
                      },
                      child: Text(
                        "CONNECT",
                      ),
                    );
                  }
                },
              );
            }
          },
        );
      },
    );
    final idTile = Builder(
      builder: (context) {
        final remoteId = context.select<BluetoothDevice, String>((d) => d.remoteId.str);
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
                final iconData = (isConnected) ? Icons.bluetooth_connected : Icons.bluetooth_disabled;
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
            return StreamProvider(
              create: (_) => device.onServicesChanged,
              initialData: device.servicesList,
              builder: (context, _) {
                loadingDiscoveringNotifier.value = false;

                // Just for updating UI.
                context.watch<List<BluetoothService>>();
                
                return ValueListenableBuilder(
                  valueListenable: loadingDiscoveringNotifier,
                  builder: (context, loading, child) {
                    final device = context.watch<BluetoothDevice>();
                    if(loading) {
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
                    }
                    else {
                      return TextButton(
                        onPressed: () async {
                          loadingDiscoveringNotifier.value = true;
                          try {
                            await device.discoverServices();
                          } catch(e) {
                            loadingDiscoveringNotifier.value = false;
                          }
                        },
                        child: const Text("Get Services"),
                      );
                    }
                  },
                );
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
                  if(mtu == null) return;
                  try {
                    await device.requestMtu(mtu);
                  } catch(e) {}
                }
              );
            },
          ),
          trailing: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  final mtu = int.tryParse(mtuText);
                  if(mtu == null) return;
                  try {
                    await device.requestMtu(mtu);
                  } catch(e) {}
                },
              );
            },
          ),
        );
      },
    );
    final writeTile = Builder(
      builder: (context) {
        if(writeField == null) return Column();
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
              final length = context.select<List<BluetoothService>, int>((services) => services.length);
              return Column(
                children: List.generate(
                  length, 
                  (index) {
                    return ProxyProvider<List<BluetoothService>, BluetoothService>(
                      update: (_, services, __) => services.elementAt(index),
                      child: serviceTile,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: nameText,
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
