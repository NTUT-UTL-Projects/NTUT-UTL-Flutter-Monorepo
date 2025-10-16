part of '../parameters.dart';

@CopyWith()
@JsonSerializable()
class CvElectrochemicalParameters
    with EquatableMixin
    implements ElectrochemicalParameters {
  final double eBegin;
  final double eVertex1;
  final double eVertex2;
  final double eStep;
  final double scanRate;
  final int numberOfScans;

  const CvElectrochemicalParameters({
    required this.eBegin,
    required this.eVertex1,
    required this.eVertex2,
    required this.eStep,
    required this.scanRate,
    required this.numberOfScans,
  });

  @override
  ElectrochemicalType get type => ElectrochemicalType.cv;

  @override
  bool get isValid => !(eBegin > eVertex1 && eBegin > eVertex2)
      && !(eBegin < eVertex1 && eBegin < eVertex2)
      && eStep > 0.0
      && scanRate > 0.0
      && numberOfScans > 0;

  @override
  int get dataLength => stepCount;

  int get stepCount {
    if (!isValid) return 0;
    return (((eVertex1 - eBegin).abs() / eStep).ceil()) +
        (((eVertex2 - eVertex1).abs() / eStep).ceil()) +
        (((eBegin - eVertex2).abs() / eStep).ceil());
  }

  Iterable<double> get voltages sync* {
    if (!isValid) return;
    for (int scan = 0; scan < numberOfScans; scan++) {
      // eBegin → eVertex1
      if (eVertex1 > eBegin) {
        for (double v = eBegin; v < eVertex1; v += eStep) {
          yield double.parse(v.toStringAsFixed(6));
        }
      } else {
        for (double v = eBegin; v > eVertex1; v -= eStep) {
          yield double.parse(v.toStringAsFixed(6));
        }
      }

      // eVertex1 → eVertex2
      if (eVertex2 > eVertex1) {
        for (double v = eVertex1; v < eVertex2; v += eStep) {
          yield double.parse(v.toStringAsFixed(6));
        }
      } else {
        for (double v = eVertex1; v > eVertex2; v -= eStep) {
          yield double.parse(v.toStringAsFixed(6));
        }
      }

      // eVertex2 → eBegin
      if (eBegin > eVertex2) {
        for (double v = eVertex2; v < eBegin; v += eStep) {
          yield double.parse(v.toStringAsFixed(6));
        }
      } else {
        for (double v = eVertex2; v > eBegin; v -= eStep) {
          yield double.parse(v.toStringAsFixed(6));
        }
      }
    }
  }

  @override
  List<Object?> get props => [
    eBegin,
    eVertex1,
    eVertex2,
    eStep,
    scanRate,
    numberOfScans,
  ];

  @override
  factory CvElectrochemicalParameters.fromJson(Map<String, dynamic> json) =>
      _$CvElectrochemicalParametersFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CvElectrochemicalParametersToJson(this);
}
