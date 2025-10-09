part of '../seat_cushion.dart';

enum SeatCushionUnitPointType {
  mm,
  lb,
  lt,
  rb,
  rt,
}

class SeatCushionUnitPoint extends Equatable {
  final SeatCushionUnitPointType type;

  final SeatCushionUnit unit;
  
  const SeatCushionUnitPoint._({
    required this.type,
    required this.unit,
  });

  SeatCushion get seatCushion => unit.seatCushion;

  int get row => unit.row;
  int get column => unit.column;

  static Point<double> typeRowColumnToPosition({
    required SeatCushionUnitPointType type,
    required int row,
    required int column,
  }) {
    switch(type) {
      case SeatCushionUnitPointType.mm:
        return Point(
          (column - SeatCushion.unitsHalfMaxColumn + 0.5) * SeatCushionUnit.sensorWidth,
          (row - SeatCushion.unitsHalfMaxRow + 0.5) * SeatCushionUnit.sensorHeight,
        );
      case SeatCushionUnitPointType.lb:
        return Point(
          (column - SeatCushion.unitsHalfMaxColumn + 0.0) * SeatCushionUnit.sensorWidth,
          (row - SeatCushion.unitsHalfMaxRow + 1.0) * SeatCushionUnit.sensorHeight,
        );
      case SeatCushionUnitPointType.lt:
        return Point(
          (column - SeatCushion.unitsHalfMaxColumn + 0.0) * SeatCushionUnit.sensorWidth,
          (row - SeatCushion.unitsHalfMaxRow + 0.0) * SeatCushionUnit.sensorHeight,
        );
      case SeatCushionUnitPointType.rb:
        return Point(
          (column - SeatCushion.unitsHalfMaxColumn + 1.0) * SeatCushionUnit.sensorWidth,
          (row - SeatCushion.unitsHalfMaxRow + 1.0) * SeatCushionUnit.sensorHeight,
        );
      case SeatCushionUnitPointType.rt:
        return Point(
          (column - SeatCushion.unitsHalfMaxColumn + 1.0) * SeatCushionUnit.sensorWidth,
          (row - SeatCushion.unitsHalfMaxRow + 0.0) * SeatCushionUnit.sensorHeight,
        );
    }
  }

  Point<double> get position => typeRowColumnToPosition(
    type: type,
    row: row,
    column: column,
  );

  double get force {
    switch(type) {
      case SeatCushionUnitPointType.mm:
        return seatCushion.forces[row][column];
      case SeatCushionUnitPointType.lb:
      {
        final list = [
          seatCushion.forces[row][column],
          ((row + 1) < SeatCushion.unitsMaxRow)
            ? seatCushion.forces[row + 1][column + 0] : 0.0,
          ((column - 1) >= 0)
            ? seatCushion.forces[row + 0][column - 1] : 0.0,
          ((row + 1) < SeatCushion.unitsMaxRow && (column - 1) >= 0)
            ? seatCushion.forces[row + 1][column - 1] : 0.0,
        ];
        return list.reduce((a, b) => a + b) / list.length;
      }
      case SeatCushionUnitPointType.lt:
      {
        final list = [
          seatCushion.forces[row][column],
          ((row - 1) >= 0)
            ? seatCushion.forces[row - 1][column + 0] : 0.0,
          ((column - 1) >= 0)
            ? seatCushion.forces[row + 0][column - 1] : 0.0,
          ((row - 1) >= 0 && (column - 1) >= 0)
            ? seatCushion.forces[row - 1][column - 1] : 0.0,
        ];
        return list.reduce((a, b) => a + b) / list.length;
      }
      case SeatCushionUnitPointType.rb:
      {
        final list = [
          seatCushion.forces[row][column],
          ((row + 1) < SeatCushion.unitsMaxRow)
            ? seatCushion.forces[row + 1][column + 0] : 0.0,
          ((column + 1) < SeatCushion.unitsMaxColumn)
            ? seatCushion.forces[row + 0][column + 1] : 0.0,
          ((row + 1) < SeatCushion.unitsMaxRow && (column + 1) < SeatCushion.unitsMaxColumn)
            ? seatCushion.forces[row + 1][column + 1] : 0.0,
        ];
        return list.reduce((a, b) => a + b) / list.length;
      }
      case SeatCushionUnitPointType.rt:
      {
        final list = [
          seatCushion.forces[row][column],
          ((row - 1) >= 0)
            ? seatCushion.forces[row - 1][column + 0] : 0.0,
          ((column + 1) < SeatCushion.unitsMaxColumn)
            ? seatCushion.forces[row + 0][column + 1] : 0.0,
          ((row - 1) >= 0 && (column + 1) < SeatCushion.unitsMaxColumn)
            ? seatCushion.forces[row - 1][column + 1] : 0.0,
        ];
        return list.reduce((a, b) => a + b) / list.length;
      }
    }
  }
  
  @override
  List<Object?> get props => [
    unit,
  ];

}
