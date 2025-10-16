// Copyright 2024-2025, Zhen-Xiang Chen.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Wei-Zhe decoder.
///
/// This decoder is used to collect values ​​and then send the seat
/// cushion data via stream when the conditions are met.
library;

import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:synchronized/synchronized.dart';

import '../../seat_cushion.dart';
import 'template.dart';

@visibleForTesting
@pragma('vm:notify-debugger-on-exception')
enum WeiZheDecoderValuesStage {
  first,
  second,
  third,
}

class WeiZheDecoder implements SeatCushionSensorDecoder {
  final Map<SeatCushionType, Map<WeiZheDecoderValuesStage, List<int>?>>
  _buffer = {
    for (var v in SeatCushionType.values)
      v: {for (var v in WeiZheDecoderValuesStage.values) v: null},
  };

  final _leftController = StreamController<LeftSeatCushion>.broadcast();

  final _rightController = StreamController<RightSeatCushion>.broadcast();

  final _lock = Lock();

  @override
  Stream<LeftSeatCushion> get leftStream => _leftController.stream;

  @override
  Stream<RightSeatCushion> get rightStream => _rightController.stream;

  @visibleForTesting
  @pragma('vm:notify-debugger-on-exception')
  SeatCushionType? valuesToSeatCushionType(List<int> values) {
    if (values.first & 0xF0 == 0x10) return SeatCushionType.right;
    if (values.first & 0xF0 == 0x20) return SeatCushionType.left;
    return null;
  }

  @visibleForTesting
  @pragma('vm:notify-debugger-on-exception')
  WeiZheDecoderValuesStage? valuesToStage(List<int> values) {
    if (values.first & 0x0F == 0x01) return WeiZheDecoderValuesStage.first;
    if (values.first & 0x0F == 0x02) return WeiZheDecoderValuesStage.second;
    if (values.first & 0x0F == 0x03) return WeiZheDecoderValuesStage.third;
    return null;
  }

  @visibleForTesting
  @pragma('vm:notify-debugger-on-exception')
  int stageToLength(WeiZheDecoderValuesStage stage) {
    switch (stage) {
      case WeiZheDecoderValuesStage.first:
        return 243;
      case WeiZheDecoderValuesStage.second:
        return 243;
      case WeiZheDecoderValuesStage.third:
        return 13;
    }
  }

  @visibleForTesting
  @pragma('vm:notify-debugger-on-exception')
  List<double> valuesToForces(List<int> values) {
    final byteData = ByteData.sublistView(Uint8List.fromList(values));
    return [
      for (var i = 0; i < byteData.lengthInBytes; i += 2)
        byteData.getInt16(i, Endian.little).toDouble(),
    ];
  }

  @visibleForTesting
  @pragma('vm:notify-debugger-on-exception')
  int indexToRow({
    required SeatCushionType type,
    required int index,
  }) {
    switch (type) {
      case SeatCushionType.left:
        return index ~/ SeatCushion.unitsMaxColumn;
      case SeatCushionType.right:
        return (SeatCushion.unitsMaxRow - 1) -
            (index ~/ SeatCushion.unitsMaxColumn);
    }
  }

  @visibleForTesting
  @pragma('vm:notify-debugger-on-exception')
  int indexToColumn({
    required SeatCushionType type,
    required int index,
  }) {
    switch (type) {
      case SeatCushionType.left:
        return (SeatCushion.unitsMaxColumn - 1) -
            (index % SeatCushion.unitsMaxColumn);
      case SeatCushionType.right:
        return index % SeatCushion.unitsMaxColumn;
    }
  }

  @visibleForTesting
  @pragma('vm:notify-debugger-on-exception')
  int rowColumnToIndex({
    required SeatCushionType type,
    required int row,
    required int column,
  }) {
    switch (type) {
      case SeatCushionType.left:
        return (row * SeatCushion.unitsMaxColumn) +
            ((SeatCushion.unitsMaxColumn - 1) - column);
      case SeatCushionType.right:
        return (((SeatCushion.unitsMaxRow - 1) - row) *
                SeatCushion.unitsMaxColumn) +
            column;
    }
  }

  /// Add the values to the buffer​ ​and then send the seat
  /// cushion data via stream when the conditions are met.
  @override
  Future<void> addValues(List<int> values) async {
    return await _lock.synchronized(() {
      /// Check the type is valid.
      final type = valuesToSeatCushionType(values);
      if (type == null) return;

      /// Check the stage is valid.
      final stage = valuesToStage(values);
      if (stage == null) return;

      /// Check the length is valid.
      final length = stageToLength(stage);
      if (length != values.length) return;

      /// Update the buffer.
      _buffer[type]!.update(stage, (_) => values);

      /// Checks whether each stage values of the buffer of this type is ready.
      final allStageValuesIsNotEmpty = !_buffer[type]!.values.fold(
        false,
        (result, values) => result || (values == null),
      );

      if (allStageValuesIsNotEmpty) {
        /// Get the force list.
        final rawForces = valuesToForces(
          _buffer[type]!.values.expand((e) => e!.skip(1)).toList(),
        );

        /// Map the force list to 2D-list.
        final forces = List.generate(SeatCushion.unitsMaxRow, (row) {
          return List.generate(SeatCushion.unitsMaxColumn, (column) {
            return rawForces[rowColumnToIndex(
              type: type,
              row: row,
              column: column,
            )];
          });
        });

        /// Get current time.
        final time = DateTime.now();

        /// Add the seat cushion data to the corresponding stream.
        switch (type) {
          case SeatCushionType.left:
            _leftController.add(LeftSeatCushion(forces: forces, time: time));
          case SeatCushionType.right:
            _rightController.add(RightSeatCushion(forces: forces, time: time));
        }

        /// Clear the buffer of this type.
        for (final stage in WeiZheDecoderValuesStage.values) {
          _buffer[type]!.update(stage, (_) => null);
        }
      }
    });
  }

  /// Generate a mock values for testing.
  List<int> generateMokeValues() {
    final random = Random.secure();
    final header = ((random.nextInt(2) + 1) << 4) | (random.nextInt(3) + 1);
    final stage = valuesToStage([header])!;
    final length = stageToLength(stage) - 1;
    return [
      header,
      ...List.generate((length / 2.0).toInt(), (index) {
        /// Force
        final force = (random.nextDouble() * (SeatCushion.forceMax - SeatCushion.forceMin)) + SeatCushion.forceMin;
        final forceBytes = (ByteData(2)
          ..setInt16(0, force.toInt(), Endian.little))
          .buffer
          .asUint8List();

        return [
          ...forceBytes,
        ];
      }).expand((e) => e)
    ];
  }

  /// Close the stream.
  void close() {
    _leftController.close();
    _rightController.close();
  }
}
