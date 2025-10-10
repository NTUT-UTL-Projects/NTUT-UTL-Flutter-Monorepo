import 'package:flutter_test/flutter_test.dart';
import 'package:seat_cushion/infrastructure/sensor_decoder/wei_zhe_decoder.dart';

import 'package:seat_cushion/seat_cushion.dart';

class WeiZheDecoderTester {
  final SeatCushionType type;
  final int row;
  final int column;
  final int index;

  WeiZheDecoderTester({required this.type, required this.row, required this.column, required this.index});

  void runTest() {
    final decoder = WeiZheDecoder();
    expect(
      decoder.indexToColumn(
        type: type,
        index: index,
      ),
      column,
    );
    expect(
      decoder.indexToRow(
        type: type,
        index: index,
      ),
      row,
    );
    expect(
      decoder.rowColumnToIndex(
        type: type,
        row: row,
        column: column,
      ),
      index,
    );
  }
}

void main() {
  test('Wei-Zhe decoder', () {
    WeiZheDecoderTester(
      type: SeatCushionType.left,
      row: 0,
      column: (SeatCushion.unitsMaxColumn - 1),
      index: 0,
    ).runTest();
    WeiZheDecoderTester(
      type: SeatCushionType.left,
      row: (SeatCushion.unitsMaxRow - 1),
      column: 0,
      index: (SeatCushion.unitsMaxIndex - 1),
    ).runTest();
    WeiZheDecoderTester(
      type: SeatCushionType.right,
      row: (SeatCushion.unitsMaxRow - 1),
      column: 0,
      index: 0,
    ).runTest();
    WeiZheDecoderTester(
      type: SeatCushionType.right,
      row: 0,
      column: (SeatCushion.unitsMaxColumn - 1),
      index: (SeatCushion.unitsMaxIndex - 1),
    ).runTest();
  });
}
