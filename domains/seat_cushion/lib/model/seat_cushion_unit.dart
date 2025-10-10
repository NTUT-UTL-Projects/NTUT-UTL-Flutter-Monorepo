part of '../seat_cushion.dart';

class SeatCushionUnit extends Equatable {
  static const double sensorAspectRatio = SeatCushionUnit.sensorWidth / SeatCushionUnit.sensorHeight;
  static const double sensorHeight = 7.5;
  static const double sensorWidth = 10.0;

  final int row;
  final int column;
  final SeatCushion seatCushion;

  const SeatCushionUnit({
    required this.row,
    required this.column,
    required this.seatCushion,
  });

  SeatCushionUnitPoint get lbPoint => SeatCushionUnitPoint._(type: SeatCushionUnitPointType.lb, unit: this);
  SeatCushionUnitPoint get ltPoint => SeatCushionUnitPoint._(type: SeatCushionUnitPointType.lt, unit: this);
  SeatCushionUnitPoint get mmPoint => SeatCushionUnitPoint._(type: SeatCushionUnitPointType.mm, unit: this);
  SeatCushionUnitPoint get rbPoint => SeatCushionUnitPoint._(type: SeatCushionUnitPointType.rb, unit: this);
  SeatCushionUnitPoint get rtPoint => SeatCushionUnitPoint._(type: SeatCushionUnitPointType.rt, unit: this);

  @override
  List<Object?> get props => [
    row,
    column,
    seatCushion,
  ];

}