import 'dart:async';

import 'package:stream_utils/stream_util.dart';

import '../../seat_cushion.dart';

class MockSeatCushionSensor implements SeatCushionSensor {
  final StreamController<LeftSeatCushion> _leftController =
      StreamController.broadcast();

  final StreamController<RightSeatCushion> _rightController =
      StreamController.broadcast();

  final StreamController<SeatCushionSet> _setController =
      StreamController.broadcast();

  LeftSeatCushion? _leftBuffer;

  RightSeatCushion? _rightBuffer;

  MockSeatCushionSensor();

  @override
  Stream<LeftSeatCushion> get leftStream => _leftController.stream;

  @override
  Stream<RightSeatCushion> get rightStream => _rightController.stream;

  @override
  Stream<SeatCushionSet> get setStream => _setController.stream;

  @override
  Stream<SeatCushion> get stream => mergeStreams([
    leftStream,
    rightStream,
  ]);

  void mockLeft(LeftSeatCushion left) {
    _leftBuffer = left;
    _leftController.add(left);
    if (_leftBuffer != null && _rightBuffer != null) {
      _setController.add(
        SeatCushionSet(left: _leftBuffer!, right: _rightBuffer!),
      );
    }
  }

  void mockRight(RightSeatCushion right) {
    _rightBuffer = right;
    _rightController.add(right);
    if (_leftBuffer != null && _rightBuffer != null) {
      _setController.add(
        SeatCushionSet(left: _leftBuffer!, right: _rightBuffer!),
      );
    }
  }

  void mockSet(SeatCushionSet set) {
    _leftBuffer = set.left;
    _rightBuffer = set.right;
    _leftController.add(set.left);
    _rightController.add(set.right);
    if (_leftBuffer != null && _rightBuffer != null) {
      _setController.add(
        SeatCushionSet(left: _leftBuffer!, right: _rightBuffer!),
      );
    }
  }

  void close() {
    _leftController.close();
    _rightController.close();
    _setController.close();
  }
}
