part of 'bluetooth_command_view.dart';

class BluetoothCommandView extends StatelessWidget {
  const BluetoothCommandView({super.key});
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final themeExtension = themeData.extension<BluetoothCommandViewTheme>();

    final controller = context
        .select<BluetoothCommandViewController, TextEditingController>(
          (c) => c.textEditingController,
        );

    final triggerClear = context
        .select<BluetoothCommandViewController, VoidCallback>(
          (c) => c.triggerClear,
        );
    final clearButton = IconButton(
      onPressed: triggerClear,
      icon: Icon(themeExtension?.clearIcon),
      color: themeExtension?.clearColor,
    );

    final triggerInit = context
        .select<BluetoothCommandViewController, VoidCallback>(
          (c) => c.triggerInit,
        );
    final initButton = IconButton(
      onPressed: triggerInit,
      icon: Icon(themeExtension?.initIcon),
      color: themeExtension?.initColor,
    );

    final triggerSend = context
        .select<BluetoothCommandViewController, VoidCallback>(
          (c) => (() => c.sendPacket(controller)),
        );
    final sendButton = IconButton(
      onPressed: triggerSend,
      icon: Icon(themeExtension?.sendIcon),
      color: themeExtension?.sendColor,
    );

    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [sendButton, initButton, clearButton],
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Hex Input',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.multiline,
                inputFormatters: [HexFormatter()],
                maxLines: null,
                minLines: null,
                showCursor: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
