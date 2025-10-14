import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_cushion/seat_cushion.dart';
import 'package:seat_cushion_presentation/seat_cushion_presentation.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        extensions: [
          SeatCushionForceWidgetTheme(
            borderColor: Colors.white,
          ),
          SeatCushionIschiumPointWidgetTheme(
            borderColor: Colors.white,
            ischiumColor: Colors.pinkAccent,
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
            create: (_) => SeatCushionForceWidgetUI(
              forceToColor: weiZheForceToColorConverter,
            ),
          ),
        ],
        child: SeatCushionSetView(),
      ),
    );
  }
}
