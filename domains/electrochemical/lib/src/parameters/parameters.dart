import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parameters.g.dart';
part 'src/ca.dart';
part 'src/cv.dart';
part 'src/dpv.dart';

enum ElectrochemicalType {
  ca,
  cv,
  dpv,
}

abstract class ElectrochemicalParameters {
  ElectrochemicalType get type;
  bool get isValid;
  int get dataLength;
  Map<String, dynamic> toJson();
}
