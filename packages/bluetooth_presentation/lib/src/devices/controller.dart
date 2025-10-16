part of 'bluetooth_device_tile.dart';

/// Provides logic for scanning and managing Bluetooth devices.
/// Intended to be mixed into classes that extend [ChangeNotifier].
///
/// **References**
/// - [BluetoothDevice]
/// - [fbp.BluetoothDevice]
mixin BluetoothDevicesController on ChangeNotifier {
  final List<StreamSubscription> _sub = [];

  // Flutter Blue Plus
  @protected
  late final bool fbpIsSupported;
  @protected
  Set<fbp.BluetoothDevice> fbpSystemDevices = {};
  @protected
  Iterable<fbp.BluetoothDevice> get fbpAllDevices => {
    ...fbpSystemDevices,
    ...BondFlutterBluePlus.bondedDevices,
    ...ScanResultFlutterBluePlus.lastScannedDevices,
  };

  @mustCallSuper
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
    this.fbpSystemDevices = fbpSystemDevices.toSet();
    this.fbpToggleSelection = fbpToggleSelection;
    if (fbpIsSupported) {
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

  Future<void> setScanning(bool isOn) async {
    for (final permission in bluetoothPermissions) {
      if (!(await permission.request()).isGranted) {
        return;
      }
    }
    if (isOn) {
      // Flutter Blue Plus
      if (fbpIsSupported) {
        try {
          fbpSystemDevices = (await fbp.FlutterBluePlus.systemDevices(
            [],
          )).toSet();
          await BondFlutterBluePlus.updateBondedDevices();
          await fbp.FlutterBluePlus.startScan(
            timeout: const Duration(seconds: 15),
          );
        } catch (e) {}
      }
    } else {
      // Flutter Blue Plus
      if (fbpIsSupported) {
        try {
          await fbp.FlutterBluePlus.stopScan();
        } catch (e) {}
      }
    }
    notifyListeners();
  }

  Future<void> toggleScanning() async {
    for (final permission in bluetoothPermissions) {
      if (!(await permission.request()).isGranted) {
        return;
      }
    }
    // Flutter Blue Plus
    await setScanning(!fbp.FlutterBluePlus.isScanningNow);
    return;
  }

  bool get isScanning {
    // Flutter Blue Plus
    if (!fbpIsSupported) return false;
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
      .map(fbpDeviceToDevice);

  // Flutter Blue Plus
  @protected
  fbp.BluetoothDevice? deviceToFbpDevice(BluetoothDevice device) {
    return fbpAllDevices
      .where((d) => 
        d.remoteId.str == device.id
      )
      .firstOrNull;
  }

  // Flutter Blue Plus
  @protected
  BluetoothDevice fbpDeviceToDevice(fbp.BluetoothDevice device) {
    final isConnectable =
        ScanResultFlutterBluePlus.lastScanResults
            .where((r) => r.device == device)
            .firstOrNull
            ?.advertisementData
            .connectable ??
        false;
    VoidCallback? togglePairing;
    if (device.isBondable && !device.isBonded) {
      togglePairing = () async {
        for (final permission in bluetoothPermissions) {
          if (!(await permission.request()).isGranted) {
            return;
          }
        }
        try {
          await device.createBond();
        } catch (e) {}
      };
    }
    if (device.isUnBondable && device.isBonded) {
      togglePairing = () async {
        for (final permission in bluetoothPermissions) {
          if (!(await permission.request()).isGranted) {
            return;
          }
        }
        try {
          await device.removeBond();
        } catch (e) {}
      };
    }
    return BluetoothDevice(
      id: device.remoteId.str,
      inSystem: fbpSystemDevices.contains(device),
      isPaired: BondFlutterBluePlus.bondedDevices.contains(device),
      isConnectable: isConnectable,
      isConnected: device.isConnected,
      isScanned: ScanResultFlutterBluePlus.lastScannedDevices.contains(device),
      isSelected: fbpIsSelected?.call(device) ?? false,
      name: device.platformName,
      rssi: device.rssi ?? 0,
      tech: BluetoothTech.lowEnergy,
      toggleConnection: (isConnectable)
          ? () async {
              for (final permission in bluetoothPermissions) {
                if (!(await permission.request()).isGranted) {
                  return;
                }
              }
              if (device.isConnected) {
                try {
                  await device.disconnect(queue: true);
                } catch (e) {}
              } else {
                try {
                  await device.connect(
                    license: License.free,
                    autoConnect: true,
                    mtu: null,
                  );
                } catch (e) {}
              }
            }
          : null,
      togglePairing: togglePairing,
      toggleSelection: (fbpToggleSelection != null)
          ? () => fbpToggleSelection!(device)
          : null,
    );
  }

  @mustCallSuper
  void cancelDevicesController() {
    for (final s in _sub) {
      s.cancel();
    }
  }
}
