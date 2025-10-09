part of '../../seat_cushion_presentation.dart';

class SeatCushionSetView extends StatelessWidget {
  final bool showForcesMatrix;
  final bool showIschiumPoint;
  const SeatCushionSetView({
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
        final maxHeight = (constraints.maxWidth > SeatCushionSet.deviceAspectRatio)
          ? constraints.maxWidth / SeatCushionSet.deviceAspectRatio
          : constraints.maxHeight;
        return Row(
          children: [
            SizedBox(
              width: maxWidth * (SeatCushion.deviceWidth / SeatCushionSet.deviceWidth),
              height: maxHeight,
              child: ProxyProvider<SeatCushionSet?, LeftSeatCushion?>(
                create: (_) => null,
                update: (_, set, _) => set?.left,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        if(showForcesMatrix)
                          SeatCushionForcesMatrixWidget<LeftSeatCushion>(),
                        if(showIschiumPoint)
                          SeatCushionIschiumPointWidget<LeftSeatCushion>(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: maxWidth * (SeatCushionSet.deviceWidth - (2 * SeatCushion.deviceWidth)) / SeatCushionSet.deviceWidth,
              height: maxHeight,
              child: Column(),
            ),
            SizedBox(
              width: maxWidth * (SeatCushion.deviceWidth / SeatCushionSet.deviceWidth),
              height: maxHeight,
              child: ProxyProvider<SeatCushionSet?, RightSeatCushion?>(
                create: (_) => null,
                update: (_, set, _) => set?.right,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        if(showForcesMatrix)
                          SeatCushionForcesMatrixWidget<RightSeatCushion>(),
                        if(showIschiumPoint)
                          SeatCushionIschiumPointWidget<RightSeatCushion>(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}