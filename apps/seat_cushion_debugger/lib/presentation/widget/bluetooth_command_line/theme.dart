part of 'bluetooth_command_line.dart';

@immutable
@TailorMixin()
class BluetoothCommandLineTheme
    extends ThemeExtension<BluetoothCommandLineTheme>
    with _$BluetoothCommandLineThemeTailorMixin {
  @override
  final Color clearColor;
  @override
  final IconData clearIcon;
  @override
  final Color initColor;
  @override
  final IconData initIcon;
  @override
  final Color sendColor;
  @override
  final IconData sendIcon;

  const BluetoothCommandLineTheme({
    required this.clearColor,
    required this.clearIcon,
    required this.initColor,
    required this.initIcon,
    required this.sendColor,
    required this.sendIcon,
  });
}
