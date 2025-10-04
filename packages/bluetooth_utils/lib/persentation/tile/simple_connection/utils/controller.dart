part of '../bluetooth_device_tile.dart';

mixin BluetoothDevicesChangeNotifier on ChangeNotifier {
  final List<StreamSubscription> _sub = [];

  // Flutter Blue Plus
  @protected
  List<fbp.BluetoothDevice> fbpSystemDevices = [];
  @protected
  Iterable<fbp.BluetoothDevice> get fbpAllDevices => fbpSystemDevices
    .followedBy(BondFlutterBluePlus.bondedDevices)
    .followedBy(ScanResultFlutterBluePlus.lastScannedDevices);

  @protected
  void init({
    required List<fbp.BluetoothDevice> fbpSystemDevices,
  }) {
      // Flutter Blue Plus
    this.fbpSystemDevices.addAll(fbpSystemDevices);
    _sub.addAll([
      fbp.FlutterBluePlus.isScanning.listen((isScanning) {
        notifyListeners();
      }),
      ConnectionStateFlutterBluePlus.onConnectionStateChanged.listen((isScanning) {
        notifyListeners();
      }),
      RssiFlutterBluePlus.onAllRssi.listen((isScanning) {
        notifyListeners();
      }),
      ScanResultFlutterBluePlus.onScanResponse.listen((isScanning) {
        notifyListeners();
      }),
    ]);
  }

  void toggleScanning() async {
    // Flutter Blue Plus
    fbpSystemDevices = (await fbp.FlutterBluePlus.systemDevices([])).toList();
    if(fbp.FlutterBluePlus.isScanningNow) {
      await fbp.FlutterBluePlus.stopScan();
    } else {
      await fbp.FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 15),
      );
    }
    notifyListeners();
  }

  bool get isScanning {
    // Flutter Blue Plus
    return fbp.FlutterBluePlus.isScanningNow;
  }

  @protected
  bool isSelectedFbp(fbp.BluetoothDevice device);

  @protected
  void toggleSelectionFbp(fbp.BluetoothDevice device);

  Iterable<BluetoothDevice> get devices sync* {
    // Flutter Blue Plus
    for(final d in fbpAllDevices) {
      yield BluetoothDevice(
        id: d.remoteId.str,
        isConnectable: ScanResultFlutterBluePlus.lastScanResults.where((r) => r.device == d).firstOrNull?.advertisementData.connectable ?? false,
        isConnected: d.isConnected,
        isScanned: ScanResultFlutterBluePlus.lastScannedDevices.contains(d),
        isSelected: isSelectedFbp(d),
        name: d.platformName,
        rssi: d.rssi ?? 0,
        tech: BluetoothTech.lowEnergy,
        toggleConnection: () async {
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
        toggleSelection: () => toggleSelectionFbp(d),
      );
    }
  }

  void cancel() {
    for(final s in _sub) {
      s.cancel();
    }
  }
}
