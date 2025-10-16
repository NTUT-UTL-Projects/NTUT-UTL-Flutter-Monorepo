// Copyright 2024-2025, Zhen-Xiang Chen.

/// Seat cushion sensor data decoder template.
library;

import 'dart:async';

import '../../seat_cushion.dart';

/// ------------------------------
/// [SeatCushionSensorDecoder]
/// ------------------------------
///
/// This is a tool template for decoding data from [SeatCushionSensor].
abstract class SeatCushionSensorDecoder {
  /// [LeftSeatCushion] stream
  Stream<LeftSeatCushion> get leftStream;

  /// [RightSeatCushion] stream
  Stream<RightSeatCushion> get rightStream;

  /// Add the values to the buffer​ ​and then send the seat
  /// cushion data via stream when the conditions are met.
  Future<void> addValues(List<int> values);
}
