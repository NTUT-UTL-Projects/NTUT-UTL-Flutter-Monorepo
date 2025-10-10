part of '../seat_cushion.dart';

/// --------------------------------------------
/// [SeatCushionSensor]
/// --------------------------------------------
///
/// Sensor interface for receiving [SeatCushion] data streams.
///
/// This abstract class defines the **data input layer** of the seat cushion system.
/// It provides multiple real-time [Stream] interfaces for accessing sensor data
/// from different regions or aggregation levels of the cushion.
///
/// Typically, a concrete implementation of this interface connects to
/// hardware devices, simulators, or communication channels that emit
/// continuous seat cushion readings.
///
/// ## Streams
/// - **[leftStream]** → Emits [LeftSeatCushion] data (left side readings)
/// - **[rightStream]** → Emits [RightSeatCushion] data (right side readings)
/// - **[setStream]** → Emits [SeatCushionSet], representing the full set of sensors
/// - **[stream]** → Emits a generic [SeatCushion], independent of side or grouping
///
/// Implementers should ensure proper error handling and stream closing
/// to prevent memory leaks or inconsistent data flow.
abstract class SeatCushionSensor {
  /// Stream of [LeftSeatCushion] data, representing readings from the left region.
  Stream<LeftSeatCushion> get leftStream;

  /// Stream of [RightSeatCushion] data, representing readings from the right region.
  Stream<RightSeatCushion> get rightStream;

  /// Stream of [SeatCushionSet] data, containing combined sensor states.
  Stream<SeatCushionSet> get setStream;

  /// General-purpose stream of [SeatCushion] data, for unified access.
  Stream<SeatCushion> get stream;
}
