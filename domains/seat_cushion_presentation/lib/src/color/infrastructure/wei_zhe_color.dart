import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:seat_cushion/seat_cushion.dart';

import '../color.dart';

ForceToColorConverter weiZheForceToColorConverter = (force) {
  final hueMax = 255;
  final hueMin = -45;
  final hue =
      (((SeatCushion.forceMax -
                  clampDouble(
                    force,
                    SeatCushion.forceMin,
                    SeatCushion.forceMax,
                  )) /
              (SeatCushion.forceMax - SeatCushion.forceMin) *
              (hueMax - hueMin)) +
          hueMin) %
      360.0;
  return HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor();
};
