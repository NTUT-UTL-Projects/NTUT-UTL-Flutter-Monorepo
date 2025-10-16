part of '../seat_cushion.dart';

/// --------------------------------------------
/// [SeatCushionSet]
/// --------------------------------------------
///
/// A data model representing a **paired seat cushion system**, composed of
/// one [LeftSeatCushion] and one [RightSeatCushion].
///
/// This class serves as the **aggregated unit** of the entire cushion surface,
/// combining both sides into a single measurable and serializable structure.
@CopyWith()
@JsonSerializable()
class SeatCushionSet extends Equatable {
  /// The aspect ratio of the combined device area (width / height).
  static double deviceAspectRatio = deviceWidth / deviceHeight;

  /// The total horizontal dimension of the dual-cushion system.
  ///
  /// Computed from both individual [SeatCushion.deviceWidth] values and
  /// the positional offset between [LeftSeatCushion] and [RightSeatCushion].
  static double deviceWidth =
      (SeatCushion.deviceWidth) +
      (LeftSeatCushion.basePosition.x - RightSeatCushion.basePosition.x).abs();

  /// The vertical dimension of the device (identical for both sides).
  static double deviceHeight = SeatCushion.deviceHeight;

  /// The left-side cushion data.
  @JsonKey(toJson: LeftSeatCushion._toJson)
  final LeftSeatCushion left;

  /// The right-side cushion data.
  @JsonKey(toJson: RightSeatCushion._toJson)
  final RightSeatCushion right;

  /// Creates a paired seat cushion set containing both left and right units.
  const SeatCushionSet({
    required this.left,
    required this.right,
  });

  /// Calculates the **ischium width** (distance between left and right sitting bones).
  ///
  /// The result is computed using Euclidean distance between each cushion’s
  /// detected [SeatCushion.ischiumPosition] adjusted by their respective [basePosition].
  double get ischiumWidth {
    final lP = left.ischiumPosition() + LeftSeatCushion.basePosition;
    final rP = right.ischiumPosition() + RightSeatCushion.basePosition;
    final dx = (rP.x - lP.x);
    final dy = (rP.y - lP.y);
    return sqrt(pow(dx, 2) + pow(dy, 2));
  }

  /// Used by the [Equatable] package to support value equality.
  @override
  List<Object?> get props => [
    left,
    right,
  ];

  /// Deserializes a [SeatCushionSet] object from JSON.
  factory SeatCushionSet.fromJson(Map<String, dynamic> json) =>
      _$SeatCushionSetFromJson(json);

  /// Serializes this [SeatCushionSet] to a JSON-compatible map.
  Map<String, dynamic> toJson() => _$SeatCushionSetToJson(this);

  static Map<String, dynamic> _toJson(SeatCushionSet seatCushionSet) =>
      seatCushionSet.toJson();
}
