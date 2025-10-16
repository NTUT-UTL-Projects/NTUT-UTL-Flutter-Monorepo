part of '../seat_cushion.dart';

/// --------------------------------------------
/// [SeatCushionUnit]
/// --------------------------------------------
///
/// Represents a **single pressure-sensing unit** (grid cell) within a [SeatCushion].
///
/// Each unit corresponds to one physical sensor element on the seat cushion surface,
/// identified by its [row] and [column] indices. The class provides convenient access
/// to the unit’s geometric reference points (corners and center), each represented
/// by a [SeatCushionUnitCornerPoint].
///
/// This class is used extensively in spatial calculations such as:
/// - Force distribution visualization
/// - Center of pressure computation
/// - Mesh generation for 3D rendering
class SeatCushionUnit extends Equatable {
  /// Aspect ratio of each sensor unit (width / height).
  static const double sensorAspectRatio =
      SeatCushionUnit.sensorWidth / SeatCushionUnit.sensorHeight;

  /// Physical height of one sensor unit in millimeters.
  static const double sensorHeight = 7.5;

  /// Physical width of one sensor unit in millimeters.
  static const double sensorWidth = 10.0;

  /// The row index of this unit within the seat cushion grid.
  final int row;

  /// The column index of this unit within the seat cushion grid.
  final int column;

  /// The [SeatCushion] instance to which this unit belongs.
  final SeatCushion seatCushion;

  /// Creates a [SeatCushionUnit] identified by its [row], [column],
  /// and parent [seatCushion].
  const SeatCushionUnit({
    required this.row,
    required this.column,
    required this.seatCushion,
  });

  /// Bottom-left corner point of this sensor unit.
  SeatCushionUnitCornerPoint get blPoint => SeatCushionUnitCornerPoint._(
    type: SeatCushionUnitCornerPointType.bottomLeft,
    unit: this,
  );

  /// Bottom-right corner point of this sensor unit.
  SeatCushionUnitCornerPoint get brPoint => SeatCushionUnitCornerPoint._(
    type: SeatCushionUnitCornerPointType.bottomRight,
    unit: this,
  );

  /// Center point of this sensor unit.
  SeatCushionUnitCornerPoint get mmPoint => SeatCushionUnitCornerPoint._(
    type: SeatCushionUnitCornerPointType.center,
    unit: this,
  );

  /// Top-left corner point of this sensor unit.
  SeatCushionUnitCornerPoint get tlPoint => SeatCushionUnitCornerPoint._(
    type: SeatCushionUnitCornerPointType.topLeft,
    unit: this,
  );

  /// Top-right corner point of this sensor unit.
  SeatCushionUnitCornerPoint get trPoint => SeatCushionUnitCornerPoint._(
    type: SeatCushionUnitCornerPointType.topRight,
    unit: this,
  );

  /// Used by [Equatable] for value equality.
  @override
  List<Object?> get props => [row, column, seatCushion];
}
