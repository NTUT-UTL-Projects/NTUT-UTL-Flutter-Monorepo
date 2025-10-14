import 'package:flutter/material.dart';
import 'package:seat_cushion_presentation/seat_cushion_presentation.dart';

class SeatCushion2dExampleView extends StatelessWidget {
  const SeatCushion2dExampleView({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        extensions: [
          SeatCushionForceWidgetTheme(
            borderColor: Colors.black,
            forceToColor: weiZheForceToColorConverter,
          ),
          SeatCushionIschiumPointWidgetTheme(
            borderColor: Colors.black,
            ischiumColor: Colors.pinkAccent,
          ),
        ],
      ),
      darkTheme: ThemeData(
        extensions: [
          SeatCushionForceWidgetTheme(
            borderColor: Colors.white,
            forceToColor: weiZheForceToColorConverter,
          ),
          SeatCushionIschiumPointWidgetTheme(
            borderColor: Colors.white,
            ischiumColor: Colors.pinkAccent,
          ),
        ],
      ),
      themeMode: ThemeMode.system,
      home: AllSeatCushionView(),
    );
  }
}
