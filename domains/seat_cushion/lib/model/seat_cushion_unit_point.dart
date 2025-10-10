part of '../seat_cushion.dart';

/// --------------------------------------------
/// [SeatCushionUnitCornerPointType]
/// --------------------------------------------
///
/// Defines the geometric reference points within a [SeatCushionUnit].
///
/// Used by [SeatCushionUnitCornerPoint] to determine coordinates and interpolated forces.
enum SeatCushionUnitCornerPointType {
  bottomLeft,
  bottomRight,
  center,
  topLeft,
  topRight,
}

/// --------------------------------------------
/// [SeatCushionUnitCornerPoint]
/// --------------------------------------------
///
/// Represents a **specific reference point** (center or corner)
/// within a single [SeatCushionUnit].
///
/// Corner-point force values are averaged from adjacent sensor readings
/// to achieve smoother transitions and more accurate surface interpolation
/// when constructing 3D meshes or heatmaps.
///
/// This class plays a key role in spatial interpolation
/// for the 3D mesh renderer (`simple_3d_renderer`).
class SeatCushionUnitCornerPoint extends Equatable {
  /// The geometric type of this point (center or corner).
  final SeatCushionUnitCornerPointType type;

  /// The parent [SeatCushionUnit] that this point belongs to.
  final SeatCushionUnit unit;

  /// Private constructor, used internally by [SeatCushionUnit].
  const SeatCushionUnitCornerPoint._({
    required this.type,
    required this.unit,
  });

  /// The parent [SeatCushion] to which this unit belongs.
  SeatCushion get seatCushion => unit.seatCushion;

  /// Row index of the parent [SeatCushionUnit].
  int get row => unit.row;

  /// Column index of the parent [SeatCushionUnit].
  int get column => unit.column;

  /// Converts a point’s type and grid coordinates into its
  /// millimeter-based position on the seat cushion surface.
  ///
  /// The coordinate origin `(0, 0)` is located at the **top-left** corner
  /// of the full cushion grid.
  static Point<double> typeRowColumnToPosition({
    required SeatCushionUnitCornerPointType type,
    required int row,
    required int column,
  }) {
    switch (type) {
      case SeatCushionUnitCornerPointType.bottomLeft:
        return Point(
          (column - SeatCushion.unitsHalfMaxColumn + 0.0) *
              SeatCushionUnit.sensorWidth,
          (row - SeatCushion.unitsHalfMaxRow + 1.0) *
              SeatCushionUnit.sensorHeight,
        );

      case SeatCushionUnitCornerPointType.bottomRight:
        return Point(
          (column - SeatCushion.unitsHalfMaxColumn + 1.0) *
              SeatCushionUnit.sensorWidth,
          (row - SeatCushion.unitsHalfMaxRow + 1.0) *
              SeatCushionUnit.sensorHeight,
        );

      case SeatCushionUnitCornerPointType.center:
        return Point(
          (column - SeatCushion.unitsHalfMaxColumn + 0.5) *
              SeatCushionUnit.sensorWidth,
          (row - SeatCushion.unitsHalfMaxRow + 0.5) *
              SeatCushionUnit.sensorHeight,
        );

      case SeatCushionUnitCornerPointType.topLeft:
        return Point(
          (column - SeatCushion.unitsHalfMaxColumn + 0.0) *
              SeatCushionUnit.sensorWidth,
          (row - SeatCushion.unitsHalfMaxRow + 0.0) *
              SeatCushionUnit.sensorHeight,
        );

      case SeatCushionUnitCornerPointType.topRight:
        return Point(
          (column - SeatCushion.unitsHalfMaxColumn + 1.0) *
              SeatCushionUnit.sensorWidth,
          (row - SeatCushion.unitsHalfMaxRow + 0.0) *
              SeatCushionUnit.sensorHeight,
        );
    }
  }

  /// The **physical position** of this corner point in millimeter coordinates.
  Point<double> get position => typeRowColumnToPosition(
        type: type,
        row: row,
        column: column,
      );

  /// The **interpolated pressure value** at this corner point.
  ///
  /// - For the center point ([SeatCushionUnitCornerPointType.center]),
  ///   this directly uses the sensor’s own force value.
  /// - The force is computed as the **average of up to four adjacent
  ///   sensors** to produce smoother gradients in visualization.
  double get force {
    switch (type) {
      case SeatCushionUnitCornerPointType.bottomLeft:
        final list = [
          seatCushion.forces[row][column],
          if ((row + 1) < SeatCushion.unitsMaxRow)
            seatCushion.forces[row + 1][column],
          if ((column - 1) >= 0)
            seatCushion.forces[row][column - 1],
          if ((row + 1) < SeatCushion.unitsMaxRow && (column - 1) >= 0)
            seatCushion.forces[row + 1][column - 1],
        ];
        return list.reduce((a, b) => a + b) / list.length;

      case SeatCushionUnitCornerPointType.bottomRight:
        final list = [
          seatCushion.forces[row][column],
          if ((row + 1) < SeatCushion.unitsMaxRow)
            seatCushion.forces[row + 1][column],
          if ((column + 1) < SeatCushion.unitsMaxColumn)
            seatCushion.forces[row][column + 1],
          if ((row + 1) < SeatCushion.unitsMaxRow &&
              (column + 1) < SeatCushion.unitsMaxColumn)
            seatCushion.forces[row + 1][column + 1],
        ];
        return list.reduce((a, b) => a + b) / list.length;

      case SeatCushionUnitCornerPointType.center:
        return seatCushion.forces[row][column];

      case SeatCushionUnitCornerPointType.topLeft:
        final list = [
          seatCushion.forces[row][column],
          if ((row - 1) >= 0)
            seatCushion.forces[row - 1][column],
          if ((column - 1) >= 0)
            seatCushion.forces[row][column - 1],
          if ((row - 1) >= 0 && (column - 1) >= 0)
            seatCushion.forces[row - 1][column - 1],
        ];
        return list.reduce((a, b) => a + b) / list.length;

      case SeatCushionUnitCornerPointType.topRight:
        final list = [
          seatCushion.forces[row][column],
          if ((row - 1) >= 0)
            seatCushion.forces[row - 1][column],
          if ((column + 1) < SeatCushion.unitsMaxColumn)
            seatCushion.forces[row][column + 1],
          if ((row - 1) >= 0 && (column + 1) < SeatCushion.unitsMaxColumn)
            seatCushion.forces[row - 1][column + 1],
        ];
        return list.reduce((a, b) => a + b) / list.length;
    }
  }

  /// Defines equality comparison for [Equatable].
  @override
  List<Object?> get props => [
    unit,
  ];
}
