import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_cushion/seat_cushion.dart';
import 'package:seat_cushion/seat_cushion_presentation.dart';
import 'package:seat_cushion_debugger/presentation/widget/bluetooth_command_line/bluetooth_command_line.dart';
import 'package:seat_cushion_debugger/presentation/widget/seat_cushion_features_line/seat_cushion_features_line.dart';
import 'package:seat_cushion_debugger/presentation/widget/seat_cushion_force_color_bar/seat_cushion_force_color_bar.dart';

import '../../../l10n/gen_l10n/app_localizations.dart';

class SeatCushionDashboard extends StatelessWidget {
  const SeatCushionDashboard({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final ischiumPositionView = LayoutBuilder(
      builder: (context, constraints) {
        final leftIschiumPosition = context.select<SeatCushionSet?, Point<double>?>((s) => s?.left.ischiumPosition());
        final rightIschiumPosition = context.select<SeatCushionSet?, Point<double>?>((s) => s?.right.ischiumPosition());
        final appLocalizations = AppLocalizations.of(context)!;
        final themeData = Theme.of(context);
        return Row(
          children: [
            Expanded(
              child: Text(
                "${appLocalizations.ischiumPosition}: "
                  "(${leftIschiumPosition?.x.toStringAsFixed(4).padLeft(8, " ")} mm,"
                  " ${leftIschiumPosition?.y.toStringAsFixed(4).padLeft(8, " ")} mm)",
                style: themeData.textTheme.bodyLarge,
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * (SeatCushionSet.deviceWidth - (2 * SeatCushion.deviceWidth)) / SeatCushionSet.deviceWidth,
              child: Spacer(),
            ),
            Expanded(
              child: Text(
                "${appLocalizations.ischiumPosition}: "
                  "(${rightIschiumPosition?.x.toStringAsFixed(4).padLeft(8, " ")} mm,"
                  " ${rightIschiumPosition?.y.toStringAsFixed(4).padLeft(8, " ")} mm)",
                style: themeData.textTheme.bodyLarge,
              ),
            ),
          ],
        );
      },
    );
    final ischiumWidthView = Builder(
      builder: (context) {
        final ischiumWidth = context.select<SeatCushionSet?, double?>((s) => s?.ischiumWidth);
        final appLocalizations = AppLocalizations.of(context)!;
        final themeData = Theme.of(context);
        return Text(
          "${appLocalizations.ischiumWidth}: ${ischiumWidth?.toStringAsFixed(4).padLeft(8, " ")} mm",
          style: themeData.textTheme.bodyLarge,
          textAlign: TextAlign.center,
        );
      },
    );
    return ListView(
      children: [
        SeatCushionSetView(),
        ischiumPositionView,
        BluetoothCommandLine(),
        SeatCushionFeaturesLine(),
        SeatCushionForceColorBar(),
        ischiumWidthView,
      ],
    );
  }
}
