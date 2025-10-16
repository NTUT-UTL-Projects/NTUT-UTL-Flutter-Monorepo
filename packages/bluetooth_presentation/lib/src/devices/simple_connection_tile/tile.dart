export '../bluetooth_device_tile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import '../bluetooth_device_tile.dart';
part 'tile.tailor.dart';

@immutable
@TailorMixin()
class BluetoothDeviceSimpleConnectionTileTheme
    extends ThemeExtension<BluetoothDeviceSimpleConnectionTileTheme>
    with _$BluetoothDeviceSimpleConnectionTileThemeTailorMixin {
  @override
  final Color connectedColor;
  @override
  final IconData connectedIcon;
  @override
  final Color disconnectedColor;
  @override
  final IconData disconnectedIcon;
  @override
  final Color highlightColor;
  @override
  final IconData nullRssiIcon;
  @override
  final Color selectedColor;

  const BluetoothDeviceSimpleConnectionTileTheme({
    required this.connectedColor,
    required this.disconnectedColor,
    required this.highlightColor,
    required this.selectedColor,
    required this.connectedIcon,
    required this.disconnectedIcon,
    required this.nullRssiIcon,
  });

  Gradient brandGradient({
    required bool isSelected,
    required bool isConnected,
  }) {
    return LinearGradient(
      colors: [
        isSelected
            ? selectedColor
            : (isConnected ? connectedColor : disconnectedColor),
        isConnected ? connectedColor : disconnectedColor,
        isConnected ? connectedColor : disconnectedColor,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}

/// **Requirements:**
/// - [BluetoothDevice]
///
/// **Themes:**
/// - [BluetoothDeviceSimpleConnectionTileTheme]
class BluetoothDeviceSimpleConnectionTile extends StatelessWidget {
  const BluetoothDeviceSimpleConnectionTile({super.key});

  @override
  Widget build(BuildContext context) {
    final rssiText = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final themeExtension = themeData
            .extension<BluetoothDeviceSimpleConnectionTileTheme>();

        final rssi = context.select<BluetoothDevice, int>(
          (device) => device.rssi,
        );
        final isScanned = context.select<BluetoothDevice, bool>(
          (device) => device.isScanned,
        );
        return (isScanned)
          ? Text(
              rssi.toString(),
              style: themeData.textTheme.bodyMedium,
            )
          : Icon(
              themeExtension?.nullRssiIcon,
              color: themeData.textTheme.bodyMedium?.color,
            );
      },
    );

    // Title section: if deviceName is available, show both name and ID
    // Otherwise, show only the deviceId
    final title = Builder(
      builder: (context) {
        final deviceId = context.select<BluetoothDevice, String>(
          (device) => device.id,
        );
        final deviceName = context.select<BluetoothDevice, String>(
          (device) => device.name,
        );
        return (deviceName != "")
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    deviceName,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Builder(
                    builder: (context) {
                      return Text(
                        deviceId,
                        style: Theme.of(context).textTheme.bodySmall,
                      );
                    },
                  ),
                ],
              )
            : Text(deviceId);
      },
    );

    final toggleConnectionButton = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final themeExtension = themeData
            .extension<BluetoothDeviceSimpleConnectionTileTheme>();
        final highlightColor = themeExtension?.highlightColor;
        final isConnected = context.select<BluetoothDevice, bool>(
          (device) => device.isConnected,
        );
        final toggleConnection = context.select<BluetoothDevice, VoidCallback?>(
          (device) => device.toggleConnection,
        );
        final iconData = (isConnected)
            ? themeExtension?.disconnectedIcon
            : themeExtension?.connectedIcon;
        final icon = Icon(iconData);
        final color = (isConnected)
            ? themeExtension?.disconnectedColor
            : themeExtension?.connectedColor;
        return IconButton(
          color: color,
          highlightColor: highlightColor,
          icon: icon,
          onPressed: toggleConnection,
        );
      },
    );

    final listTile = ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          rssiText,
        ],
      ),
      title: title,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          toggleConnectionButton,
        ],
      ),
    );

    return Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final isConnected = context.select<BluetoothDevice, bool>(
          (device) => device.isConnected,
        );
        final isSelected = context.select<BluetoothDevice, bool>(
          (device) => device.isSelected,
        );
        final onToggleSelection = context
            .select<BluetoothDevice, VoidCallback?>(
              (device) => device.toggleSelection,
            );
        final brandGradient = themeData
            .extension<BluetoothDeviceSimpleConnectionTileTheme>()!
            .brandGradient(isSelected: isSelected, isConnected: isConnected);
        return InkWell(
          onTap: onToggleSelection,
          borderRadius: BorderRadius.circular(12),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: brandGradient,
            ),
            child: listTile,
          ),
        );
      },
    );
  }
}
