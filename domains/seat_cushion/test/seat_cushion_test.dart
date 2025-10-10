import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:seat_cushion/seat_cushion.dart';

List<List<double>> generateForces() {
  final random = Random.secure();
  return List.generate(
    SeatCushion.unitsMaxRow,
    (row) => List.generate(
      SeatCushion.unitsMaxColumn,
      (col) => (random.nextDouble() * (SeatCushion.forceMax - SeatCushion.forceMin)) + SeatCushion.forceMin,
    )
  );
}

void main() {
  test('Seat Cushion Json Converter', () {
    final left = LeftSeatCushion(
      forces: generateForces(),
      time: DateTime.now(),
    );
    final right = RightSeatCushion(
      forces: generateForces(),
      time: DateTime.now(),
    );
    final seatCushionSet = SeatCushionSet(left: left, right: right);
    final seatCushionSetToJson = seatCushionSet.toJson();
    final seatCushionSetFromJson = SeatCushionSet.fromJson(seatCushionSetToJson);
    expect(
      seatCushionSet,
      seatCushionSetFromJson,
    );
  });
}
