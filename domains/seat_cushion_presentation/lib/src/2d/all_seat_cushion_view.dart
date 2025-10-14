import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_cushion/seat_cushion.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import '../color/color.dart';

part 'force/seat_cushion_forces_matrix_widget.dart';
part 'force/widget/seat_cushion_force_widget.dart';
part 'ischium/seat_cushion_ischium_point_widget.dart';
part 'all_seat_cushion_view.tailor.dart';

/// --------------------------------------------
/// [AllSeatCushionView]
/// --------------------------------------------
///
/// A **stateless Flutter widget** that visualizes a [LeftSeatCushion]
/// and a [RightSeatCushion] as an 2D view.
///
/// **Requirements:**
/// - [LeftSeatCushion]
/// - [RightSeatCushion]
///
/// **References:**
/// - Refer to [SeatCushionForcesMatrixWidget].
/// - Refer to [SeatCushionIschiumPointWidget].
class AllSeatCushionView extends StatelessWidget {
  final bool showForcesMatrix;
  final bool showIschiumPoint;
  const AllSeatCushionView({
    super.key,
    this.showForcesMatrix = true,
    this.showIschiumPoint = true,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final aspectRatio = constraints.maxWidth / constraints.maxHeight;
        final maxWidth = (aspectRatio > SeatCushionSet.deviceAspectRatio)
            ? constraints.maxHeight * SeatCushionSet.deviceAspectRatio
            : constraints.maxWidth;
        final maxHeight =
            (constraints.maxWidth > SeatCushionSet.deviceAspectRatio)
            ? constraints.maxWidth / SeatCushionSet.deviceAspectRatio
            : constraints.maxHeight;
        return Row(
          children: [
            SizedBox(
              width:
                  maxWidth *
                  (SeatCushion.deviceWidth / SeatCushionSet.deviceWidth),
              height: maxHeight,
              child: Column(
                children: [
                  Stack(
                    children: [
                      if (showForcesMatrix)
                        SeatCushionForcesMatrixWidget<LeftSeatCushion>(),
                      if (showIschiumPoint)
                        SeatCushionIschiumPointWidget<LeftSeatCushion>(),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width:
                  maxWidth *
                  (SeatCushionSet.deviceWidth - (2 * SeatCushion.deviceWidth)) /
                  SeatCushionSet.deviceWidth,
              height: maxHeight,
              child: Column(),
            ),
            SizedBox(
              width:
                  maxWidth *
                  (SeatCushion.deviceWidth / SeatCushionSet.deviceWidth),
              height: maxHeight,
              child: Column(
                children: [
                  Stack(
                    children: [
                      if (showForcesMatrix)
                        SeatCushionForcesMatrixWidget<RightSeatCushion>(),
                      if (showIschiumPoint)
                        SeatCushionIschiumPointWidget<RightSeatCushion>(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
