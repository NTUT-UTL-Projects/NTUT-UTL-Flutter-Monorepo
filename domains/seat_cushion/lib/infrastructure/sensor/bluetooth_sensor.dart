import 'dart:async';

import 'package:bluetooth_utils/bluetooth_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:stream_utils/stream_util.dart';

import '../../seat_cushion.dart';
import '../sensor_decoder/template.dart';

/// --------------------------------------------
/// [BluetoothSeatCushionSensor]
/// --------------------------------------------
///
/// A concrete implementation of [SeatCushionSensor] that receives
/// seat cushion data via Bluetooth.
///
/// This class listens to raw bluetooth characteristic and descriptor updates,
/// decodes them using a [SeatCushionSensorDecoder], and emits
/// structured data streams:
/// - [leftStream] → individual left cushion updates
/// - [rightStream] → individual right cushion updates
/// - [setStream] → combined cushion pair as [SeatCushionSet]
///
/// ## Usage
/// 1. The user must first call:
///    ```dart
///    characteristic.setNotifyValue(true);
///    ```
///    to enable bluetooth notifications for real-time data reception.
/// 2. Instantiate this class with a [SeatCushionSensorDecoder].
/// 3. Listen to one or more of the provided data streams.
///
/// ## Example
/// ```dart
/// final sensor = BluetoothSeatCushionSensor(...);
///
/// sensor.setStream.listen((set) {
///   print('Left: ${set.left.totalForce()} | Right: ${set.right.totalForce()}');
/// });
/// ```
///
/// ## Lifecycle
/// Call [cancel] when the sensor is no longer needed to close all subscriptions
/// and free resources.
class BluetoothSeatCushionSensor implements SeatCushionSensor {
  /// Responsible for converting raw bluetooth data into [SeatCushion] objects.
  final SeatCushionSensorDecoder decoder;

  @protected
  final bool fbpIsSupported;

  final List<StreamSubscription> _sub = [];

  /// Buffer for the latest left cushion data.
  LeftSeatCushion? _leftBuffer;

  /// Buffer for the latest right cushion data.
  RightSeatCushion? _rightBuffer;

  final StreamController<SeatCushionSet> _setController =
      StreamController.broadcast();

  /// Creates a Bluetooth-based seat cushion sensor.
  ///
  /// If [fbpIsSupported] is true, the constructor automatically listen to
  /// [CharacteristicFlutterBluePlus.onCharacteristicReceived] and
  /// [DescriptorFlutterBluePlus.onDescriptorReceived].
  BluetoothSeatCushionSensor({
    required this.decoder,
    required this.fbpIsSupported,
  }) {
    _sub.addAll([
      /// Bind [FlutterBluePlus] notifications to the decoder if supported.
      if (fbpIsSupported)
        CharacteristicFlutterBluePlus.onCharacteristicReceived.listen(
          (c) => decoder.addValues(c.lastReceivedValue),
        ),
      if (fbpIsSupported)
        DescriptorFlutterBluePlus.onDescriptorReceived.listen(
          (d) => decoder.addValues(d.lastReceivedValue),
        ),

      /// Listen to decoded left cushion stream.
      decoder.leftStream.listen((b) {
        _leftBuffer = b;
        if (_leftBuffer != null && _rightBuffer != null) {
          _setController.add(
            SeatCushionSet(left: _leftBuffer!, right: _rightBuffer!),
          );
        }
      }),

      /// Listen to decoded right cushion stream.
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

  /// Stream of decoded [LeftSeatCushion] data from the bluetooth device.
  @override
  Stream<LeftSeatCushion> get leftStream => decoder.leftStream;

  /// Stream of decoded [RightSeatCushion] data from the bluetooth device.
  @override
  Stream<RightSeatCushion> get rightStream => decoder.rightStream;

  /// Stream that emits a complete [SeatCushionSet] whenever
  /// both [_leftBuffer] and [_rightBuffer] are available.
  @override
  Stream<SeatCushionSet> get setStream => _setController.stream;

  /// Merged stream of all decoded [SeatCushion] data
  /// (both left and right cushions combined into a single flow).
  @override
  Stream<SeatCushion> get stream => mergeStreams([leftStream, rightStream]);

  /// Cancels all active subscriptions and closes the stream controller.
  ///
  /// This should be called when the Bluetooth sensor is no longer in use.
  void cancel() {
    for (final s in _sub) {
      s.cancel();
    }
    _setController.close();
  }
}
