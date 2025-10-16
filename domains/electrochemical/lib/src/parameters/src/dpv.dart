part of '../parameters.dart';

enum DpvElectrochemicalParametersInversionOption {
  none,
  both,
  cathodic,
  anodic,
}

@CopyWith()
@JsonSerializable()
class DpvElectrochemicalParameters
    with EquatableMixin
    implements ElectrochemicalParameters {
  final double eBegin;
  final double eEnd;
  final double eStep;
  final double ePulse;
  final double tPulse;
  final double scanRate;
  final DpvElectrochemicalParametersInversionOption inversionOption;

  const DpvElectrochemicalParameters({
    required this.eBegin,
    required this.eEnd,
    required this.eStep,
    required this.ePulse,
    required this.tPulse,
    required this.scanRate,
    required this.inversionOption,
  });

  @override
  ElectrochemicalType get type => ElectrochemicalType.dpv;

  @override
  int get dataLength => stepCount * 2;

  @override
  bool get isValid => eStep > 0.0
      && ePulse > 0.0
      && tPulse > 0.0
      && scanRate > 0.0;

  int get stepCount {
    if (!isValid) return 0;
    return ((eEnd - eBegin).abs() / eStep).floor() + 1;
  }

  Iterable<double> get baseVoltages sync* {
    if (!isValid) return;
    if (eEnd >= eBegin) {
      for (double v = eBegin; v <= eEnd; v += eStep) {
        yield double.parse(v.toStringAsFixed(6));
      }
    } else {
      for (double v = eBegin; v >= eEnd; v -= eStep) {
        yield double.parse(v.toStringAsFixed(6));
      }
    }
  }

  Iterable<double> get pulseVoltages {
    if (!isValid) return Iterable.empty();
    return baseVoltages.map((v) => v + ePulseDirectional);
  }

  Iterable<double> get appliedVoltages sync* {
    if (!isValid) return;
    final stepList = baseVoltages.toList(growable: false);
    final pulseList = pulseVoltages.toList(growable: false);
    for (int i = 0; i < stepCount; i++) {
      yield stepList.elementAt(i);
      yield pulseList.elementAt(i);
    }
  }

  double get ePulseDirectional {
    if (!isValid) return 0.0;
    switch (inversionOption) {
      case DpvElectrochemicalParametersInversionOption.none:
        return ((eEnd > eBegin) ? eStep : -eStep);
      case DpvElectrochemicalParametersInversionOption.both:
        return ((eEnd > eBegin) ? -eStep : eStep);
      case DpvElectrochemicalParametersInversionOption.cathodic:
        return eStep;
      case DpvElectrochemicalParametersInversionOption.anodic:
        return -eStep;
    }
  }

  @override
  String toString() {
    return "$eBegin, $eEnd, $eStep, $ePulse, $tPulse, $scanRate, ${inversionOption.name}";
  }

  @override
  List<Object?> get props => [
    eBegin,
    eEnd,
    eStep,
    ePulse,
    tPulse,
    scanRate,
    inversionOption,
  ];

  @override
  factory DpvElectrochemicalParameters.fromJson(Map<String, dynamic> json) =>
      _$DpvElectrochemicalParametersFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DpvElectrochemicalParametersToJson(this);
}
