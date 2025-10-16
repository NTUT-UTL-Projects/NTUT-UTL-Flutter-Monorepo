part of 'bluetooth_command_line.dart';

class BluetoothCommandLine extends StatelessWidget {
  const BluetoothCommandLine({super.key});
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final themeExtension = themeData.extension<BluetoothCommandLineTheme>();

    final controller = context
        .select<BluetoothCommandLineController, TextEditingController>(
          (c) => c.textEditingController,
        );

    final triggerClear = context
        .select<BluetoothCommandLineController, VoidCallback>(
          (c) => c.triggerClear,
        );
    final clearButton = IconButton(
      onPressed: triggerClear,
      icon: Icon(themeExtension?.clearIcon),
      color: themeExtension?.clearColor,
    );

    final triggerInit = context
        .select<BluetoothCommandLineController, VoidCallback>(
          (c) => c.triggerInit,
        );
    final initButton = IconButton(
      onPressed: triggerInit,
      icon: Icon(themeExtension?.initIcon),
      color: themeExtension?.initColor,
    );

    final triggerSend = context
        .select<BluetoothCommandLineController, VoidCallback>(
          (c) => (() => c.sendPacket(controller)),
        );
    final sendButton = IconButton(
      onPressed: triggerSend,
      icon: Icon(themeExtension?.sendIcon),
      color: themeExtension?.sendColor,
    );

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Hex Input'),
            keyboardType: TextInputType.text,
            inputFormatters: [HexFormatter()],
            showCursor: true,
          ),
        ),
        sendButton,
        initButton,
        clearButton,
      ],
    );
  }
}
