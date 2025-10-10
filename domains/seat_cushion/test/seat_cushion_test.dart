import 'package:flutter_test/flutter_test.dart';
import 'package:seat_cushion/infrastructure/sensor_decoder/wei_zhe_decoder.dart';

import 'package:seat_cushion/seat_cushion.dart';

class WeiZheDecoderTester {
  final SeatCushionType type;
  final int row;
  final int column;
  final int index;

  WeiZheDecoderTester({required this.type, required this.row, required this.column, required this.index});
}

void main() {
  test('Wei-Zhe decoder', () {
    final decoder = WeiZheDecoder();
    final tester = [
      WeiZheDecoderTester(
        type: SeatCushionType.left,
        row: 0,
        column: (SeatCushion.unitsMaxColumn - 1),
        index: 0,
      ),
      WeiZheDecoderTester(
        type: SeatCushionType.left,
        row: (SeatCushion.unitsMaxRow - 1),
        column: 0,
        index: (SeatCushion.unitsMaxIndex - 1),
      ),
      WeiZheDecoderTester(
        type: SeatCushionType.right,
        row: (SeatCushion.unitsMaxRow - 1),
        column: 0,
        index: 0,
      ),
      WeiZheDecoderTester(
        type: SeatCushionType.right,
        row: 0,
        column: (SeatCushion.unitsMaxColumn - 1),
        index: (SeatCushion.unitsMaxIndex - 1),
      ),
    ];
    for(final t in tester) {
      expect(
        decoder.indexToColumn(
          type: t.type,
          index: t.index,
        ),
        t.column,
      );
      expect(
        decoder.indexToRow(
          type: t.type,
          index: t.index,
        ),
        t.row,
      );
      expect(
        decoder.rowColumnToIndex(
          type: t.type,
          row: t.row,
          column: t.column,
        ),
        t.index,
      );
    }
  });
}
