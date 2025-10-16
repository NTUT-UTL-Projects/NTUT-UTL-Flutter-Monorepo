part of '../filter.dart';

extension ElectrochemicalDpvFilter on List<double> {
  /// Calculate average
  double get average => isEmpty
      ? 0
      : reduce((value, element) => value + element) / length;

  /// Calculate maximum current
  double get max => isEmpty ? 0 : reduce((a, b) => a > b ? a : b);

  /// Calculate minimum current
  double get min => isEmpty ? 0 : reduce((a, b) => a < b ? a : b);

  Iterable<double> get mapDpv sync* {
    for (var i = 1; i < length; i += 2) {
      yield elementAt(i) - elementAt(i - 1);
    }
  }
}
