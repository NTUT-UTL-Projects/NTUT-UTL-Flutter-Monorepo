part of '../bluetooth_device_tile.dart';

mixin BluetoothDevicesController on ChangeNotifier {
  final List<StreamSubscription> _sub = [];

  // Flutter Blue Plus
  @protected
  late final bool fbpIsSupported;
  @protected
  List<fbp.BluetoothDevice> fbpSystemDevices = [];
  @protected
  Iterable<fbp.BluetoothDevice> get fbpAllDevices => fbpSystemDevices
    .followedBy(BondFlutterBluePlus.bondedDevices)
    .followedBy(ScanResultFlutterBluePlus.lastScannedDevices)
    .toSet();

  @protected
  void init({
    required bool fbpIsSupported,
    required List<fbp.BluetoothDevice> fbpSystemDevices,
  }) {
    // Flutter Blue Plus
    this.fbpIsSupported = fbpIsSupported;
    this.fbpSystemDevices.addAll(fbpSystemDevices);
    if(fbpIsSupported) {
      _sub.addAll([
        fbp.FlutterBluePlus.isScanning.listen((_) {
          notifyListeners();
        }),
        BondFlutterBluePlus.onBondStateChanged.listen((_) {
          notifyListeners();
        }),
        ConnectionStateFlutterBluePlus.onConnectionStateChanged.listen((_) {
          notifyListeners();
        }),
        RssiFlutterBluePlus.onAllRssi.listen((_) {
          notifyListeners();
        }),
        ScanResultFlutterBluePlus.onScanResponse.listen((_) {
          notifyListeners();
        }),
      ]);
    }
  }

  void toggleScanning() async {
    for(final permission in bluetoothPermissions) {
      if(!(await permission.request()).isGranted) {
        return;
      }
    }
    // Flutter Blue Plus
    if(fbpIsSupported) {
      fbpSystemDevices = (await fbp.FlutterBluePlus.systemDevices([])).toList();
      if(fbp.FlutterBluePlus.isScanningNow) {
        await fbp.FlutterBluePlus.stopScan();
      } else {
        await fbp.FlutterBluePlus.startScan(
          timeout: const Duration(seconds: 15),
        );
      }
    }
    notifyListeners();
  }

  bool get isScanning {
    // Flutter Blue Plus
    if(!fbpIsSupported) return false;
    return fbp.FlutterBluePlus.isScanningNow;
  }

  @protected
  bool fbpIsSelected(fbp.BluetoothDevice device);

  @protected
  void fbpToggleSelection(fbp.BluetoothDevice device);

  Iterable<BluetoothDevice> get devices => 
    // Flutter Blue Plus
    fbpAllDevices
      .map((d) {
        return  BluetoothDevice(
          id: d.remoteId.str,
          inSystem: fbpSystemDevices.contains(d),
          isPaired: BondFlutterBluePlus.bondedDevices.contains(d),
          isConnectable: ScanResultFlutterBluePlus.lastScanResults.where((r) => r.device == d).firstOrNull?.advertisementData.connectable ?? false,
          isConnected: d.isConnected,
          isScanned: ScanResultFlutterBluePlus.lastScannedDevices.contains(d),
          isSelected: fbpIsSelected(d),
          name: d.platformName,
          rssi: d.rssi ?? 0,
          tech: BluetoothTech.lowEnergy,
          togglePairing: () async {
            for(final permission in bluetoothPermissions) {
              if(!(await permission.request()).isGranted) {
                return;
              }
            }
            if(d.isBonded) {
              try {
                await d.removeBond();
              } catch(e) {}
            } else {
              try {
                await d.createBond();
              } catch(e) {}
            }
          },
          toggleConnection: () async {
            for(final permission in bluetoothPermissions) {
              if(!(await permission.request()).isGranted) {
                return;
              }
            }
            if(d.isConnected) {
              try {
                await d.disconnect(queue: true);
              } catch(e) {}
            } else {
              try {
                await d.connect(
                  license: License.free,
                  autoConnect: true,
                  mtu: null,
                );
              } catch(e) {}
            }
          },
          toggleSelection: () => fbpToggleSelection(d),
        );
      });

  void cancel() {
    for(final s in _sub) {
      s.cancel();
    }
  }
}
