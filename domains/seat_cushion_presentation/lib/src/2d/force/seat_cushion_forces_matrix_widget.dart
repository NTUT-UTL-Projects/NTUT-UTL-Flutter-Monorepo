part of '../all_seat_cushion_view.dart';

/// **Requirements:**
/// - Refer to [SeatCushionForceWidget].
class SeatCushionForcesMatrixWidget<T extends SeatCushion>
    extends StatelessWidget {
  const SeatCushionForcesMatrixWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth / SeatCushion.unitsMaxColumn;
        final height = width / SeatCushionUnit.sensorAspectRatio;
        return Column(
          children: List.generate(SeatCushion.unitsMaxRow, (row) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(SeatCushion.unitsMaxColumn, (column) {
                return Builder(
                  builder: (context) {
                    final force = context.select<T?, double>(
                      (s) => s?.forces[row][column] ?? SeatCushion.forceMin,
                    );
                    return SeatCushionForceWidget(
                      force: force,
                      height: height,
                      width: width,
                    );
                  },
                );
              }).toList(),
            );
          }),
        );
      },
    );
  }
}
