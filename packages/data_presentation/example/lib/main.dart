import 'package:example/src/bytes_example_view.dart';
import 'package:example/src/hex_keyboard_example_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tabViewMap = {
      "Bytes": BytesExampleView(),
      "Hex Keyboard": HexKeyboardExampleView(),
    };
    return MaterialApp(
      home: DefaultTabController(
        length: tabViewMap.length,
        child: SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: false,
            appBar: TabBar(
              isScrollable: false,
              tabs: tabViewMap.keys.map((text) {
                return Text(text);
              }).toList(),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: tabViewMap.values.toList(),
            ),
          ),
        ),
      ),
    );
  }
}
