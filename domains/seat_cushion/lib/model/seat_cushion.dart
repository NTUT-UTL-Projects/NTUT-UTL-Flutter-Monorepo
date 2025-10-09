part of '../seat_cushion.dart';

enum SeatCushionType {
  left,
  right,
}

@CopyWith()
@JsonSerializable()
class SeatCushion extends Equatable {
  static const int unitsMaxRow = 31;
  static const int unitsMaxColumn = 8;
  static const int unitsMaxIndex = unitsMaxRow * unitsMaxColumn;
  static const double unitsHalfMaxRow = unitsMaxRow / 2;
  static const double unitsHalfMaxColumn = unitsMaxColumn / 2;
  
  static const double deviceAspectRatio = SeatCushion.deviceWidth / SeatCushion.deviceHeight;
  static const double deviceHeight = SeatCushionUnit.sensorHeight * unitsMaxRow;
  static const double deviceWidth = SeatCushionUnit.sensorWidth * unitsMaxColumn;

  static const double forceMax = 2500;
  static const double forceMin = 0;

  final List<List<double>> forces;
  final DateTime time;
  final SeatCushionType type;

  SeatCushion({
    required this.forces,
    required this.time,
    required this.type,
  }) {
    if(forces.length != unitsMaxRow) throw Exception("forces.length must be $unitsMaxRow.");
    if(forces.fold(false, (prev, list) => prev || (list.length != unitsMaxColumn))) throw Exception("forces[row].length must be $unitsMaxColumn.");
  }

  @override
  List<Object?> get props => [
    forces,
  ];

  double totalForce() {
    return forces.expand((e) => e).fold(
      0,
      (init, combine) => init + combine,
    );
  }

  Iterable<Iterable<SeatCushionUnit>> get units => Iterable.generate(SeatCushion.unitsMaxRow, (row) {
    return Iterable.generate(SeatCushion.unitsMaxColumn, (column) {
      return SeatCushionUnit(row: row, column: column, seatCushion: this);
    });
  });

  Point<double> centerOfForces() {
    return units.expand((e) => e).fold(
      Point(0.0, 0.0),
      (init, combine) {
        return init + (combine.mmPoint.position * combine.mmPoint.force);
      },
    ) * (1 / totalForce());
  }

  Point<double> ischiumPosition() {
    final units = this.units
      .expand((e) => e)
      .toList(growable: false)
      ..sort((a, b) => b.mmPoint.force.compareTo(a.mmPoint.force));
    var leverage = Point<double>(0, 0);
    var total = 0.0;
    for (var item in units.indexed) {
      final index = item.$1;
      final unit = item.$2;
      final force = (unit.mmPoint.force < SeatCushion.forceMax)
        ? unit.mmPoint.force
        : SeatCushion.forceMax;
      leverage += unit.mmPoint.position * unit.mmPoint.force;
      total += unit.mmPoint.force;
      if(force == SeatCushion.forceMax && index >= 9) break;
    }
    return leverage * (1 / total);
  }

  factory SeatCushion.fromJson(Map<String, dynamic> json) => _$SeatCushionFromJson(json);

  Map<String, dynamic> toJson() => _$SeatCushionToJson(this);

}

@CopyWith()
@JsonSerializable()
class LeftSeatCushion extends SeatCushion {
  LeftSeatCushion({
    required super.forces,
    required super.time,
  }) : super(
    type: SeatCushionType.left,
  );

  static LeftSeatCushion? fromProto(SeatCushion seatCushion) {
    if(seatCushion.type == SeatCushionType.left) {
      return LeftSeatCushion(
        forces: seatCushion.forces,
        time: seatCushion.time,
      );
    }
    return null;
  }

  static const Point<double> basePosition = Point(0.0, 0.0);

  factory LeftSeatCushion.fromJson(Map<String, dynamic> json) => _$LeftSeatCushionFromJson(json);

  Map<String, dynamic> toJson() => _$LeftSeatCushionToJson(this);


}

@CopyWith()
@JsonSerializable()
class RightSeatCushion extends SeatCushion {
  RightSeatCushion({
    required super.forces,
    required super.time,
  }) : super(
    type: SeatCushionType.right,
  );

  static RightSeatCushion? fromProto(SeatCushion seatCushion) {
    if(seatCushion.type == SeatCushionType.right) {
      return RightSeatCushion(
        forces: seatCushion.forces,
        time: seatCushion.time,
      );
    }
    return null;
  }

  static const Point<double> basePosition = Point(133.0, 0.0);

  factory RightSeatCushion.fromJson(Map<String, dynamic> json) => _$RightSeatCushionFromJson(json);

  Map<String, dynamic> toJson() => _$RightSeatCushionToJson(this);


}
