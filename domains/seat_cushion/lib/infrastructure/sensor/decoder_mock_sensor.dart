import 'dart:async';

import 'package:stream_utils/stream_util.dart';

import '../../seat_cushion.dart';
import '../sensor_decoder/template.dart';

class DecoderMockSeatCushionSensor implements SeatCushionSensor {
  final SeatCushionSensorDecoder decoder;

  final List<StreamSubscription> _sub = [];

  LeftSeatCushion? _leftBuffer;

  RightSeatCushion? _rightBuffer;

  final StreamController<SeatCushionSet> _setController =
      StreamController.broadcast();

  DecoderMockSeatCushionSensor({required this.decoder}) {
    _sub.addAll([
      decoder.leftStream.listen((b) {
        _leftBuffer = b;
        if (_leftBuffer != null && _rightBuffer != null) {
          _setController.add(
            SeatCushionSet(left: _leftBuffer!, right: _rightBuffer!),
          );
        }
      }),
      decoder.rightStream.listen((b) {
        _rightBuffer = b;
        if (_leftBuffer != null && _rightBuffer != null) {
          _setController.add(
            SeatCushionSet(left: _leftBuffer!, right: _rightBuffer!),
          );
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
  Stream<SeatCushion> get stream => mergeStreams([
    leftStream,
    rightStream,
  ]);

  void cancel() {
    for (final s in _sub) {
      s.cancel();
    }
    _setController.close();
  }
}
