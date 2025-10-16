part of '../ad5940.dart';

@CopyWith()
@JsonSerializable()
class AD5940Result with EquatableMixin {
  final List<double> lptias;
  final List<double> hstias;
  final List<double> temperatures;

  AD5940Result({
    required this.lptias,
    required this.hstias,
    required this.temperatures,
  });

  @override
  List<Object?> get props => [
    lptias,
    hstias,
    temperatures,
  ];

  factory AD5940Result.fromJson(Map<String, dynamic> json) =>
      _$AD5940ResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AD5940ResultToJson(this);

  static Map<String, dynamic> _toJson(AD5940Result seatCushion) =>
      seatCushion.toJson();
}
