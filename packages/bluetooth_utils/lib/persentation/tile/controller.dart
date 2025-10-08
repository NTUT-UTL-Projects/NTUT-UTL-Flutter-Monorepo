part of 'bluetooth_device_tile.dart';

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
    bool Function(fbp.BluetoothDevice device)? fbpIsSelected,
    required List<fbp.BluetoothDevice> fbpSystemDevices,
    void Function(fbp.BluetoothDevice device)? fbpToggleSelection,
  }) {
    // Flutter Blue Plus
    this.fbpIsSupported = fbpIsSupported;
    this.fbpIsSelected = fbpIsSelected;
    this.fbpSystemDevices.addAll(fbpSystemDevices);
    this.fbpToggleSelection = fbpToggleSelection;
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
      if(fbp.FlutterBluePlus.isScanningNow) {
        await fbp.FlutterBluePlus.stopScan();
      } else {
        fbpSystemDevices = (await fbp.FlutterBluePlus.systemDevices([])).toList();
        await BondFlutterBluePlus.updateBondedDevices();
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

  // Flutter Blue Plus
  @protected
  bool Function(fbp.BluetoothDevice device)? fbpIsSelected;

  @protected
  void Function(fbp.BluetoothDevice device)? fbpToggleSelection;

  Iterable<BluetoothDevice> get devices => 
    // Flutter Blue Plus
    fbpAllDevices
      .map((d) {
        final isConnectable = ScanResultFlutterBluePlus.lastScanResults.where((r) => r.device == d).firstOrNull?.advertisementData.connectable ?? false;
        VoidCallback? togglePairing;
        if(d.isBondable && !d.isBonded) {
          togglePairing = () async {
            for(final permission in bluetoothPermissions) {
              if(!(await permission.request()).isGranted) {
                return;
              }
            }
            try {
              await d.createBond();
            } catch(e) {}
          };
        }
        if(d.isUnBondable && d.isBonded) {
          togglePairing = () async {
            for(final permission in bluetoothPermissions) {
              if(!(await permission.request()).isGranted) {
                return;
              }
            }
            try {
              await d.removeBond();
            } catch(e) {}
          };
        }
        return  BluetoothDevice(
          id: d.remoteId.str,
          inSystem: fbpSystemDevices.contains(d),
          isPaired: BondFlutterBluePlus.bondedDevices.contains(d),
          isConnectable: isConnectable,
          isConnected: d.isConnected,
          isScanned: ScanResultFlutterBluePlus.lastScannedDevices.contains(d),
          isSelected: fbpIsSelected?.call(d) ?? false,
          name: d.platformName,
          rssi: d.rssi ?? 0,
          tech: BluetoothTech.lowEnergy,
          toggleConnection: (isConnectable)
            ? () async {
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
            }
            : null,
          togglePairing: togglePairing,
          toggleSelection: (fbpToggleSelection != null)
            ? () => fbpToggleSelection!(d)
            : null,
        );
      });

  // Flutter Blue Plus
  fbp.BluetoothDevice? deviceToFbpDevice(BluetoothDevice device) {
    return fbpAllDevices
      .where((d) => 
        d.remoteId.str == device.id
      )
      .firstOrNull;
  }

  void cancel() {
    for(final s in _sub) {
      s.cancel();
    }
  }
}
