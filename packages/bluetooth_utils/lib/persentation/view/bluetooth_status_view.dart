import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@immutable
class BluetoothStatusTheme extends ThemeExtension<BluetoothStatusTheme> {
  const BluetoothStatusTheme({
    required this.backGroundColor,
    required this.iconColor,
    required this.messageColor,
  });

  /// Background color of the screen (optional), defaults to light blue.
  final Color backGroundColor;

  /// The color of the icon, defaults to semi-transparent white.
  final Color iconColor;

  /// The color of the message, defaults to white.
  final Color messageColor;

  @override
  BluetoothStatusTheme copyWith({
    Color? backGroundColor,
    Color? iconColor,
    Color? messageColor,
  }) => BluetoothStatusTheme(
        backGroundColor: backGroundColor ?? this.backGroundColor,
        iconColor: iconColor ?? this.iconColor,
        messageColor: messageColor ?? this.messageColor,
      );

  @override
  BluetoothStatusTheme lerp(ThemeExtension<BluetoothStatusTheme>? other, double t) {
    if (other is! BluetoothStatusTheme) return this;
    return BluetoothStatusTheme(
      backGroundColor: Color.lerp(
          backGroundColor as Color?,
          other.backGroundColor as Color?,
          t,
        ) ??
        backGroundColor,
      iconColor: Color.lerp(
          iconColor as Color?,
          other.iconColor as Color?,
          t,
        ) ??
        iconColor,
      messageColor: Color.lerp(
          messageColor as Color?,
          other.messageColor as Color?,
          t,
        ) ??
        messageColor,
    );
  }

  factory BluetoothStatusTheme.recommended() {
    return BluetoothStatusTheme(
      backGroundColor: Colors.lightBlue,
      iconColor: Colors.white54,
      messageColor: Colors.white,
    );
  }
}

class BluetoothStatus {
  /// The text displayed on the action button, defaults to "TURN ON".
  final String Function(BuildContext context) buttonText;

  /// The icon to show (e.g., Bluetooth disabled icon).
  final IconData iconData;

  /// The message displayed under the icon, defaults to "Bluetooth Adapter is not available."
  final String Function(BuildContext context) message;

  /// The callback function executed when the button is pressed (can be null).
  /// Recommended usage: handle the "turn on Bluetooth" event here.
  final VoidCallback? onPressedButton;

  BluetoothStatus({
    this.buttonText = _buttonText,
    this.iconData = Icons.bluetooth_disabled,
    this.message = _message, 
    required this.onPressedButton, 
  });

  static String _buttonText(BuildContext context) => "TURN ON";
  static String _message(BuildContext context) => "Bluetooth Adapter is not available.";
  
  BluetoothStatus copyWith({
    String Function(BuildContext context)? buttonText,
    IconData? iconData,
    String Function(BuildContext context)? message,
    VoidCallback? onPressedButton,
  }) {
    return BluetoothStatus(
      buttonText: buttonText ?? this.buttonText,
      iconData: iconData ?? this.iconData,
      message: message ?? this.message,
      onPressedButton: onPressedButton ?? this.onPressedButton,
    );
  }

}

/// A widget that shows the Bluetooth status view.
/// Typically used when Bluetooth is not enabled or not available.
/// Provides an icon, message, and a button to turn it on.
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
        final iconData = context.select<BluetoothStatus, IconData>((s) => s.iconData);
        final iconColor = themeData.extension<BluetoothStatusTheme>()!.iconColor;
        return Icon(
          iconData,
          size: 200.0,
          color: iconColor,
        );
      },
    );

    // Message text widget
    final title = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final message = context.select<BluetoothStatus, String>((s) => s.message(context));
        final messageColor = themeData.extension<BluetoothStatusTheme>()!.messageColor;
        return Text(
          message,
          style: themeData
              .primaryTextTheme
              .titleSmall
              ?.copyWith(
            color: messageColor, // Apply custom text color
          ),
        );
      },
    );

    // Button widget to trigger the onPressed callback
    final button = Builder(
      builder: (context) {
        final buttonText = context.select<BluetoothStatus, String>((s) => s.buttonText(context));
        final onPressedButton = context.select<BluetoothStatus, VoidCallback?>((s) => s.onPressedButton);
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
        final backGroundColor = themeData.extension<BluetoothStatusTheme>()!.backGroundColor;
        return ScaffoldMessenger(
          child: Scaffold(
            backgroundColor: backGroundColor, // Set background color
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  icon,   // Bluetooth icon
                  title,  // Message text
                  button, // Action button
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
