part of '../file_utils.dart';

extension FileFormatDateTime on DateTime {
  String toFileFormat() {
    return toString()
        .replaceAll(" ", "_")
        .replaceAll(":", "-")
        .replaceAll(".", "-");
  }
}
