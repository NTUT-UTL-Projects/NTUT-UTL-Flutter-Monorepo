import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:data_presentation/data_presentation.dart';
import 'package:provider/provider.dart';

class _Controller extends ChangeNotifier {
  final _random = Random.secure();
  late final Timer _timer;
  var bytes = <int>[];
  _Controller() {
    bytes = List.generate(_random.nextInt(0xFF), (_) => _random.nextInt(0xFF));
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      bytes = List.generate(
        _random.nextInt(0xFF),
        (_) => _random.nextInt(0xFF),
      );
      notifyListeners();
    });
  }

  @mustCallSuper
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class BytesExampleView extends StatelessWidget {
  const BytesExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        extensions: [
          BytesTheme(
            colorCycle: const [Colors.red, Colors.green],
            indexColor: Colors.grey,
          ),
        ],
      ),
      home: ChangeNotifierProvider(
        create: (_) => _Controller(),
        builder: (context, _) {
          final controller = context.watch<_Controller>();
          return BytesView(bytes: controller.bytes);
        },
      ),
    );
  }
}
