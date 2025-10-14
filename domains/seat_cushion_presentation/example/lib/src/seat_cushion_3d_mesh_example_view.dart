import 'package:flutter/material.dart';
import 'package:seat_cushion_presentation/seat_cushion_presentation.dart';

class AllSeatCushionForces3DMeshWidgetTheme
    extends AllSeatCushion3DMeshWidgetTheme {
  AllSeatCushionForces3DMeshWidgetTheme({
    required super.baseColor,
    required double forceScale,
    required Color Function(double force) forceToColor,
    required super.strokeColor,
  }) : super(
         pointToColor: (point) => forceToColor(point.force),
         pointToHeight: (point) => point.force * forceScale,
       );
}

class AllSeatCushionForces3DMeshWidget
    extends AllSeatCushion3DMeshView<AllSeatCushionForces3DMeshWidgetTheme> {
  const AllSeatCushionForces3DMeshWidget({super.key});
}

class SeatCushion3dMeshExampleView extends StatelessWidget {
  const SeatCushion3dMeshExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        extensions: [
          AllSeatCushionForces3DMeshWidgetTheme(
            baseColor: Colors.black,
            forceToColor: weiZheForceToColorConverter,
            forceScale: 0.05,
            strokeColor: Colors.black,
          ),
        ],
      ),
      darkTheme: ThemeData(
        extensions: [
          AllSeatCushionForces3DMeshWidgetTheme(
            baseColor: Colors.white,
            forceToColor: weiZheForceToColorConverter,
            forceScale: 0.05,
            strokeColor: Colors.white,
          ),
        ],
      ),
      themeMode: ThemeMode.system,
      home: AllSeatCushionForces3DMeshWidget(),
    );
  }
}
