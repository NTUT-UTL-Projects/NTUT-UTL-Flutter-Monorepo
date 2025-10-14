import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_cushion/seat_cushion.dart';
import 'package:seat_cushion/infrastructure/sensor/mock_sensor.dart';

import 'src/seat_cushion_2d_example_view.dart';
import 'src/seat_cushion_3d_mesh_example_view.dart';

final sensor = MockSeatCushionSensor();
late Timer timer;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
    sensor.mockLeft(
      LeftSeatCushion(
        forces: List.generate(
          SeatCushion.unitsMaxRow,
          (_) => List.generate(
            SeatCushion.unitsMaxColumn,
            (_) =>
                Random.secure().nextDouble() *
                    (SeatCushion.forceMax - SeatCushion.forceMin) +
                SeatCushion.forceMin,
          ),
        ),
        time: DateTime.now(),
      ),
    );
    sensor.mockRight(
      RightSeatCushion(
        forces: List.generate(
          SeatCushion.unitsMaxRow,
          (_) => List.generate(
            SeatCushion.unitsMaxColumn,
            (_) =>
                Random.secure().nextDouble() *
                    (SeatCushion.forceMax - SeatCushion.forceMin) +
                SeatCushion.forceMin,
          ),
        ),
        time: DateTime.now(),
      ),
    );
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          StreamProvider(create: (_) => sensor.leftStream, initialData: null),
          StreamProvider(create: (_) => sensor.rightStream, initialData: null),
          StreamProvider(create: (_) => sensor.setStream, initialData: null),
        ],
        builder: (context, _) {
          final mediaQuery = MediaQuery.of(context);
          return (mediaQuery.size.aspectRatio > 1.0)
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: SeatCushion2dExampleView()),
                    Expanded(child: SeatCushion3dMeshExampleView()),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: SeatCushion2dExampleView()),
                    Expanded(child: SeatCushion3dMeshExampleView()),
                  ],
                );
        },
      ),
    );
  }
}
