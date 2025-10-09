part of '../seat_cushion.dart';

@CopyWith()
@JsonSerializable()
class SeatCushionSet extends Equatable {
  static double deviceAspectRatio = deviceWidth / deviceHeight;

  static double deviceWidth = (SeatCushion.deviceWidth) + (LeftSeatCushion.basePosition.x - RightSeatCushion.basePosition.x).abs();

  static double deviceHeight = SeatCushion.deviceHeight;

  final LeftSeatCushion left;

  final RightSeatCushion right;

  const SeatCushionSet({
    required this.left,
    required this.right,
  });

  double get ischiumWidth {
    final lP = left.ischiumPosition() + LeftSeatCushion.basePosition;
    final rP = right.ischiumPosition() + RightSeatCushion.basePosition;
    final dx = (rP.x - lP.x);
    final dy = (rP.y - lP.y);
    return sqrt(pow(dx, 2) + pow(dy, 2));
  }
  
  @override
  List<Object?> get props => [
    left,
    right,
  ];

  factory SeatCushionSet.fromJson(Map<String, dynamic> json) => _$SeatCushionSetFromJson(json);

  Map<String, dynamic> toJson() => _$SeatCushionSetToJson(this);

}
