part of 'bluetooth_command_line.dart';

class BluetoothCommandLine extends StatelessWidget {
  const BluetoothCommandLine({super.key});
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final themeExtension = themeData.extension<BluetoothCommandLineTheme>()!;
    final icons = context.watch<BluetoothCommandLineIcons>();

    final triggerClear = context.select<BluetoothCommandLineController, VoidCallback>((c) => c.triggerClear);
    final clearButton = IconButton(
      onPressed: triggerClear,
      icon: Icon(
        icons.clear,
      ),
      color: themeExtension.clearIconColor,
    );

    final triggerInit = context.select<BluetoothCommandLineController, VoidCallback>((c) => c.triggerInit);
    final initButton = IconButton(
      onPressed: triggerInit,
      icon: Icon(
        icons.init,
      ),
      color: themeExtension.initIconColor,
    );

    final controller = context.select<BluetoothCommandLineController, TextEditingController>((c) => c.textEditingController);
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.text,
            showCursor: true,
            inputFormatters: [
              HexFormatter(),
            ],
            decoration: const InputDecoration(
              hintText: 'Hex Input',
            ),
          ),
        ),
        initButton,
        clearButton,
      ],
    );
  }
}
