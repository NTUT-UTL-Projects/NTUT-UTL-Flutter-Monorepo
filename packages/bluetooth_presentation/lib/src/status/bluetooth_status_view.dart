import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'bluetooth_status_view.g.dart';
part 'bluetooth_status_view.tailor.dart';

@immutable
@TailorMixin()
class BluetoothStatusTheme extends ThemeExtension<BluetoothStatusTheme>
    with _$BluetoothStatusThemeTailorMixin {
  @override
  final Color backGroundColor;
  @override
  final Color iconColor;
  @override
  final Color messageColor;

  const BluetoothStatusTheme({
    this.backGroundColor = Colors.lightBlue,
    this.iconColor = Colors.white54,
    this.messageColor = Colors.white,
  });
}

@CopyWith()
class BluetoothStatusController {
  final String buttonText;
  final IconData iconData;
  final String message;
  final VoidCallback? onPressedButton;

  BluetoothStatusController({
    this.buttonText = "TURN ON",
    this.iconData = Icons.bluetooth_disabled,
    this.message = "Bluetooth Adapter is not available.",
    required this.onPressedButton,
  });
}

/// Typically used when Bluetooth is not enabled or not available.
///
/// **Requirements:**
/// - [BluetoothStatusController]
/// - [BluetoothStatusTheme]
class BluetoothStatusView extends StatelessWidget {
  /// Constructor with default values but allows customization.
  const BluetoothStatusView({
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    // Bluetooth icon widget
    final icon = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final iconData = context.select<BluetoothStatusController, IconData>(
          (s) => s.iconData,
        );
        final iconColor = themeData
            .extension<BluetoothStatusTheme>()
            ?.iconColor;
        return Icon(iconData, size: 200.0, color: iconColor);
      },
    );

    /// Message text widget
    final message = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final message = context.select<BluetoothStatusController, String>(
          (s) => s.message,
        );
        final messageColor = themeData
            .extension<BluetoothStatusTheme>()
            ?.messageColor;
        return Text(
          message,
          style: themeData.primaryTextTheme.titleSmall?.copyWith(
            color: messageColor, // Apply custom text color
          ),
        );
      },
    );

    // Button widget to trigger the onPressed callback
    final button = Builder(
      builder: (context) {
        final buttonText = context.select<BluetoothStatusController, String>(
          (s) => s.buttonText,
        );
        final onPressedButton = context
            .select<BluetoothStatusController, VoidCallback?>(
              (s) => s.onPressedButton,
            );
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: onPressedButton,
            child: Text(buttonText),
          ),
        );
      },
    );

    // The overall layout using Scaffold
    return Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final backGroundColor = themeData
            .extension<BluetoothStatusTheme>()
            ?.backGroundColor;
        return ScaffoldMessenger(
          child: Scaffold(
            backgroundColor: backGroundColor, // Set background color
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  icon,
                  message,
                  button,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
