part of '../seat_cushion.dart';

/// Defines which side of a dual-seat system the [SeatCushion] belongs to.
enum SeatCushionType {
  /// Left-side seat cushion.
  left,

  /// Right-side seat cushion.
  right,
}

/// --------------------------------------------
/// [SeatCushion]
/// --------------------------------------------
///
/// Core data model representing a single seat cushion’s pressure grid.
///
/// Each [SeatCushion] is a matrix of pressure values, where each element
/// in [forces] corresponds to a sensor unit’s measured force.
/// The model provides computed properties for analyzing posture distribution,
/// including total applied force, center of pressure, and the ischium position.
///
/// Used as the base class for [LeftSeatCushion] and [RightSeatCushion],
/// which define their own coordinate origins and offsets.
@CopyWith()
@JsonSerializable()
class SeatCushion extends Equatable {
  /// Maximum number of rows in the sensor grid.
  static const int unitsMaxRow = 31;

  /// Maximum number of columns in the sensor grid.
  static const int unitsMaxColumn = 8;

  /// Total number of sensors (rows * columns).
  static const int unitsMaxIndex = unitsMaxRow * unitsMaxColumn;

  /// Half the number of rows, used for coordinate normalization.
  static const double unitsHalfMaxRow = unitsMaxRow / 2;

  /// Half the number of columns, used for coordinate normalization.
  static const double unitsHalfMaxColumn = unitsMaxColumn / 2;

  /// Aspect ratio of the cushion surface (width / height).
  static const double deviceAspectRatio =
      SeatCushion.deviceWidth / SeatCushion.deviceHeight;

  /// Physical height of the cushion grid in millimeters.
  static const double deviceHeight = SeatCushionUnit.sensorHeight * unitsMaxRow;

  /// Physical width of the cushion grid in millimeters.
  static const double deviceWidth =
      SeatCushionUnit.sensorWidth * unitsMaxColumn;

  /// Maximum measurable force of each unit sensor.
  static const double forceMax = 2500;

  /// Minimum measurable force of each unit sensor.
  static const double forceMin = 0;

  /// 2D matrix of pressure values for all sensors.
  final List<List<double>> forces;

  /// Timestamp of this measurement.
  final DateTime time;

  /// Identifies whether this cushion is the [SeatCushionType.left] or [SeatCushionType.right] side.
  final SeatCushionType type;

  /// Creates a [SeatCushion] with a complete force matrix and timestamp.
  ///
  /// Throws an [Exception] if [forces] dimensions do not match
  /// [unitsMaxRow] * [unitsMaxColumn].
  SeatCushion({
    required this.forces,
    required this.time,
    required this.type,
  }) {
    if (forces.length != unitsMaxRow) {
      throw Exception("forces.length must be $unitsMaxRow.");
    }
    if (forces.fold(
      false,
      (prev, list) => prev || (list.length != unitsMaxColumn),
    )) {
      throw Exception("forces[row].length must be $unitsMaxColumn.");
    }
  }

  @override
  List<Object?> get props => [
    forces,
    time,
    type,
  ];

  /// Returns the total accumulated force across all sensors.
  double totalForce() {
    return forces.expand((e) => e).fold(0, (sum, f) => sum + f);
  }

  /// Returns a 2D iterable of all [SeatCushionUnit] objects in this grid.
  Iterable<Iterable<SeatCushionUnit>> get units =>
      Iterable.generate(unitsMaxRow, (row) {
        return Iterable.generate(unitsMaxColumn, (column) {
          return SeatCushionUnit(row: row, column: column, seatCushion: this);
        });
      });

  /// Calculates the **center of pressure** (weighted average of all active forces).
  Point<double> centerOfForces() {
    return units
            .expand((e) => e)
            .fold(
              Point(0.0, 0.0),
              (sum, u) => sum + (u.mmPoint.position * u.mmPoint.force),
            ) *
        (1 / totalForce());
  }

  /// Estimates the **ischium (sit-bone) position** based on the highest force regions.
  ///
  /// Sorts all units by force magnitude and averages the top contributors
  /// until a saturation threshold is reached.
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
      final force = unit.mmPoint.force < forceMax
          ? unit.mmPoint.force
          : forceMax;
      leverage += unit.mmPoint.position * unit.mmPoint.force;
      total += unit.mmPoint.force;
      if (force == forceMax && index >= 9) break;
    }

    return leverage * (1 / total);
  }

  factory SeatCushion.fromJson(Map<String, dynamic> json) =>
      _$SeatCushionFromJson(json);

  Map<String, dynamic> toJson() => _$SeatCushionToJson(this);

  static Map<String, dynamic> _toJson(SeatCushion seatCushion) =>
      seatCushion.toJson();
}

/// Specialized [SeatCushion] subclass representing the **left-side** seat.
@CopyWith()
@JsonSerializable()
class LeftSeatCushion extends SeatCushion {
  LeftSeatCushion({
    required super.forces,
    required super.time,
  }) : super(type: SeatCushionType.left);

  /// Converts a generic [SeatCushion] to a [LeftSeatCushion] if its [type] matches.
  static LeftSeatCushion? fromProto(SeatCushion seatCushion) {
    if (seatCushion.type == SeatCushionType.left) {
      return LeftSeatCushion(
        forces: seatCushion.forces,
        time: seatCushion.time,
      );
    }
    return null;
  }

  /// The coordinate base position of the left cushion.
  /// serving as the reference point for the entire [SeatCushionSet].
  static const Point<double> basePosition = Point(0.0, 0.0);

  factory LeftSeatCushion.fromJson(Map<String, dynamic> json) =>
      _$LeftSeatCushionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SeatCushionToJson(this);

  static Map<String, dynamic> _toJson(LeftSeatCushion seatCushion) =>
      seatCushion.toJson();
}

/// Specialized [SeatCushion] subclass representing the **right-side** seat.
@CopyWith()
@JsonSerializable()
class RightSeatCushion extends SeatCushion {
  RightSeatCushion({
    required super.forces,
    required super.time,
  }) : super(type: SeatCushionType.right);

  /// Converts a generic [SeatCushion] to a [RightSeatCushion] if its [type] matches.
  static RightSeatCushion? fromProto(SeatCushion seatCushion) {
    if (seatCushion.type == SeatCushionType.right) {
      return RightSeatCushion(
        forces: seatCushion.forces,
        time: seatCushion.time,
      );
    }
    return null;
  }

  /// The coordinate base position of the right cushion.
  /// serving as the reference point for the entire [SeatCushionSet].
  static const Point<double> basePosition = Point(133.0, 0.0);

  factory RightSeatCushion.fromJson(Map<String, dynamic> json) =>
      _$RightSeatCushionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SeatCushionToJson(this);

  static Map<String, dynamic> _toJson(RightSeatCushion seatCushion) =>
      seatCushion.toJson();
}
