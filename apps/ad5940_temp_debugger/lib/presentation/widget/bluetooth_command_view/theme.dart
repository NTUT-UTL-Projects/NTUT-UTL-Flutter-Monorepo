part of 'bluetooth_command_view.dart';

@immutable
@TailorMixin()
class BluetoothCommandViewTheme
    extends ThemeExtension<BluetoothCommandViewTheme>
    with _$BluetoothCommandViewThemeTailorMixin {
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

  const BluetoothCommandViewTheme({
    required this.clearColor,
    required this.clearIcon,
    required this.initColor,
    required this.initIcon,
    required this.sendColor,
    required this.sendIcon,
  });
}
