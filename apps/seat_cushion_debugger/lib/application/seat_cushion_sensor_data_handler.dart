import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:seat_cushion/seat_cushion.dart';
import 'package:synchronized/synchronized.dart';

class SeatCushionSensorRecorderController {
  @protected
  final SeatCushionSensor sensor;
  @protected
  final SeatCushionRepository repository;

  final List<StreamSubscription> _sub = [];

  final _lock = Lock();

  final StreamController<bool> _isRecordingController =
      StreamController.broadcast();
  Stream<bool> get isRecordingStream => _isRecordingController.stream;
  bool _isRecording = false;
  bool get isRecording => _isRecording;
  set isRecording(bool isRecording) {
    _lock.synchronized(() {
      if (_isRecording == isRecording) return;
      _isRecording = isRecording;
      _isRecordingController.add(_isRecording);
    });
  }

  SeatCushionSensorRecorderController({
    required this.sensor,
    required this.repository,
  }) {
    _sub.addAll([
      sensor.stream.listen((seatCushion) {
        _lock.synchronized(() {
          if (!_isRecording) return;
          repository.add(seatCushion: seatCushion);
        });
      }),
    ]);
  }

  void cancel() {
    for (final s in _sub) {
      s.cancel();
    }
  }
}
