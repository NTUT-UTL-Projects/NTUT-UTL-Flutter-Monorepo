import 'dart:async';

import 'package:bluetooth_utils/utils/flutter_blue_plus_utils.dart';
import 'package:stream_utils/stream_util.dart';

import '../../seat_cushion.dart';
import '../sensor_decoder/decoder.dart';

class BluetoothSeatCushionSensor implements SeatCushionSensor {
  final SeatCushionSensorDecoder decoder;

  final bool fbpIsSupported;

  final List<StreamSubscription> _sub = [];

  LeftSeatCushion? _leftBuffer;

  RightSeatCushion? _rightBuffer;

  final StreamController<SeatCushionSet> _setController = StreamController.broadcast();

  BluetoothSeatCushionSensor({
    required this.decoder,
    required this.fbpIsSupported,
  }) {
    _sub.addAll([
      if(fbpIsSupported)
        CharacteristicFlutterBluePlus.onCharacteristicReceived.listen((c) => decoder.addValues(c.lastReceivedValue)),
      if(fbpIsSupported)
        DescriptorFlutterBluePlus.onDescriptorReceived.listen((d) => decoder.addValues(d.lastReceivedValue)),
      decoder.leftStream.listen((b) {
        _leftBuffer = b;
        if(_leftBuffer != null && _rightBuffer != null) {
          _setController.add(SeatCushionSet(left: _leftBuffer!, right: _rightBuffer!));
        }
      }),
      decoder.rightStream.listen((b) {
        _rightBuffer = b;
        if(_leftBuffer != null && _rightBuffer != null) {
          _setController.add(SeatCushionSet(left: _leftBuffer!, right: _rightBuffer!));
        }
      }),
    ]);
  }

  @override
  Stream<LeftSeatCushion> get leftStream => decoder.leftStream;
  
  @override
  Stream<RightSeatCushion> get rightStream => decoder.rightStream;

  @override
  Stream<SeatCushionSet> get setStream => _setController.stream;

  @override
  Stream<SeatCushion> get stream => mergeStreams(
    [
      leftStream,
      rightStream,
    ]
  );

  void cancel() {
    for(final s in _sub) {
      s.cancel();
    }
    _setController.close();
  }
}
