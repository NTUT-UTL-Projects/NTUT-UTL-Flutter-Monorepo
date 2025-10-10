import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_cushion/infrastructure/color/wei_zhe_color.dart';
import 'package:seat_cushion/seat_cushion.dart';
import 'package:seat_cushion/seat_cushion_presentation.dart';

final seatCushionSensor = StreamController<SeatCushionSet>.broadcast();
late Timer timer;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  timer = Timer.periodic(
    const Duration(milliseconds: 300),
    (_) {
      seatCushionSensor.add(SeatCushionSet(
        left: LeftSeatCushion(
          forces: List.generate(
            SeatCushion.unitsMaxRow,
            (_) => List.generate(
              SeatCushion.unitsMaxColumn,
              (_) => Random.secure().nextDouble() * (SeatCushion.forceMax - SeatCushion.forceMin) + SeatCushion.forceMin,
            ),
          ),
          time: DateTime.now(),
        ),
        right: RightSeatCushion(
          forces: List.generate(
            SeatCushion.unitsMaxRow,
            (_) => List.generate(
              SeatCushion.unitsMaxColumn,
              (_) => Random.secure().nextDouble() * (SeatCushion.forceMax - SeatCushion.forceMin) + SeatCushion.forceMin,
            ),
          ),
          time: DateTime.now(),
        ),
      ));
    },
  );
  runApp(const MyApp());
}

class SeatCushionForce3DMeshWidgetUI extends SeatCushion3DMeshWidgetUI {
  @override
  final double cameraHight;
  
  @override
  final double focusLength;

  final double focusScale;

  SeatCushionForce3DMeshWidgetUI({
    required this.cameraHight,
    required this.focusLength,
    required this.focusScale,
  });
  
  @override
  Color pointToColor(ThemeData themeData, SeatCushionUnitCornerPoint point) {
    return weiZheForceToColorConverter(themeData, point.force);
  }
  
  @override
  double pointToHeight(ThemeData themeData, SeatCushionUnitCornerPoint point) {
    return point.force * focusScale;
  }
}

class SeatCushionForce3dMeshWidget extends SeatCushion3DMeshView<SeatCushionForce3DMeshWidgetUI> {
  const SeatCushionForce3dMeshWidget({super.key});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        extensions: [
          SeatCushion3DMeshWidgetTheme(
            baseColor: Colors.white,
            strokeColor: Colors.white,
          ),
        ],
      ),
      home: MultiProvider(
        providers: [
          StreamProvider<SeatCushionSet?>(
            create: (_) => seatCushionSensor.stream,
            initialData: null,
          ),
          Provider(
            create: (_) => SeatCushionForce3DMeshWidgetUI(
              cameraHight: 1200.0,
              focusLength: 1500.0,
              focusScale: 0.05,
            ),
          ),
        ],
        child: SeatCushionForce3dMeshWidget(),
      ),
    );
  }
}
