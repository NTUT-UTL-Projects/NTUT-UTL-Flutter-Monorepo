part of 'bluetooth_command_line.dart';

class BluetoothCommandLineIcons {
  final IconData clear;
  final IconData init;
  final IconData send;

  BluetoothCommandLineIcons({required this.clear, required this.init, required this.send});
}

@immutable
class BluetoothCommandLineTheme extends ThemeExtension<BluetoothCommandLineTheme> {
  const BluetoothCommandLineTheme({
    required this.clearIconColor,
    required this.initIconColor,
  });

  final Color clearIconColor;
  final Color initIconColor;

  @override
  BluetoothCommandLineTheme copyWith({
    Color? clearIconColor,
    Color? initIconColor,
  }) => BluetoothCommandLineTheme(
        clearIconColor: clearIconColor ?? this.clearIconColor,
        initIconColor: initIconColor ?? this.initIconColor,
      );

  @override
  BluetoothCommandLineTheme lerp(ThemeExtension<BluetoothCommandLineTheme>? other, double t) {
    if (other is! BluetoothCommandLineTheme) return this;
    return BluetoothCommandLineTheme(
      clearIconColor: Color.lerp(
          clearIconColor as Color?,
          other.clearIconColor as Color?,
          t,
        ) ??
        clearIconColor,
      initIconColor: Color.lerp(
          initIconColor as Color?,
          other.initIconColor as Color?,
          t,
        ) ??
        initIconColor,
    );
  }
}