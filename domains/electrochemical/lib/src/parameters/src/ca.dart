part of '../parameters.dart';

@CopyWith()
@JsonSerializable()
class CaElectrochemicalParameters
    with EquatableMixin
    implements ElectrochemicalParameters {
  final double eDc;
  final double tInterval;
  final double tRun;

  const CaElectrochemicalParameters({
    required this.eDc,
    required this.tInterval,
    required this.tRun,
  });

  @override
  ElectrochemicalType get type => ElectrochemicalType.ca;

  @override
  bool get isValid => tInterval > 0.0
      && tRun > 0.0
      && tRun >= tInterval;

  @override
  int get dataLength => ((tRun / tInterval).floor()) + 1;

  Iterable<double> get times {
    if (!isValid) return Iterable.empty();
    return Iterable.generate(dataLength, (n) => tInterval * n);
  }

  @override
  List<Object?> get props => [
      eDc,
      tInterval,
      tRun,
  ];

  @override
  factory CaElectrochemicalParameters.fromJson(Map<String, dynamic> json) =>
      _$CaElectrochemicalParametersFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CaElectrochemicalParametersToJson(this);
}
