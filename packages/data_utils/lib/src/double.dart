part of '../data_utils.dart';

extension Precision on double {
  /// This method rounds the double to 'n' decimal places
  /// ```dart
  /// print(3.1415926.toPrecision(3)); // 3.141
  /// ```
  double toPrecision(int n) {
    return (this * pow(10, n)).roundToDouble() / pow(10, n);
  }
}
