import 'package:flutter/material.dart';
import 'package:data_presentation/data_presentation.dart';
import 'package:provider/provider.dart';

class HexKeyboardExampleView extends StatelessWidget {
  const HexKeyboardExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        extensions: [
          HexKeyboardTheme(
            backspaceColor: Colors.orange,
            clearColor: Colors.red,
            submitColor: Colors.green,
          ),
        ],
      ),
      home: Builder(
        builder: (context) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => TextEditingController()),
              ChangeNotifierProvider(create: (_) => FocusNode()),
            ],
            builder: (context, _) {
              final controller = context.watch<TextEditingController>();
              final focusNode = context.watch<FocusNode>();
              return Column(
                children: [
                  HexKeyboardInputField(
                    controller: controller,
                    focusNode: focusNode,
                  ),
                  HexKeyboard(
                    controller: controller,
                    focusNode: focusNode,
                    onSubmitted: () {},
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
