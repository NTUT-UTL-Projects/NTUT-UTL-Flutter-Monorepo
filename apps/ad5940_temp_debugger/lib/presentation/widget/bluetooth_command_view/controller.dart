part of 'bluetooth_command_view.dart';

class BluetoothCommandViewController extends ChangeNotifier {
  @protected
  final void Function(TextEditingController controller) sendPacket;

  @protected
  final VoidCallback triggerInit;

  @protected
  final TextEditingController textEditingController = TextEditingController();

  BluetoothCommandViewController({
    required this.sendPacket,
    required this.triggerInit,
  });

  void triggerClear() {
    textEditingController.clear();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
