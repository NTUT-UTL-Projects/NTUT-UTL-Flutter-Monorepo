part of 'bluetooth_command_line.dart';

class BluetoothCommandLineController extends ChangeNotifier {
  @protected
  final void Function(TextEditingController controller) sendPacket;

  @protected
  final VoidCallback triggerInit;

  @protected
  final TextEditingController textEditingController = TextEditingController();

  BluetoothCommandLineController({
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
