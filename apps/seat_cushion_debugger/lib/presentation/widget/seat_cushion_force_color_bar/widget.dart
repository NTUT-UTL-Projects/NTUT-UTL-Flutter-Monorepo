part of 'seat_cushion_force_color_bar.dart';

class SeatCushionForceColorBar extends StatelessWidget {
  const SeatCushionForceColorBar({super.key});
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final themeExtension = themeData.extension<SeatCushionForceColorBarTheme>();
    final layer = 64;
    return Column(
      children: [
        Container(
          height: themeData.textTheme.bodySmall?.fontSize,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: List.generate(
                layer,
                (index) =>
                    themeExtension?.forceToColor(
                      (((SeatCushion.forceMax - SeatCushion.forceMin) * index) /
                              layer) +
                          SeatCushion.forceMin,
                    ) ??
                    Colors.black,
              ),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        Row(
          children: [
            Text((SeatCushion.forceMin / 1000.0).toString()),
            Spacer(),
            Text((SeatCushion.forceMax / 1000.0).toString()),
          ],
        ),
      ],
    );
  }
}
