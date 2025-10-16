export '../bluetooth_device_tile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import '../bluetooth_device_tile.dart';
part 'tile.tailor.dart';

@immutable
@TailorMixin()
class BluetoothDeviceDetailsTileTheme
    extends ThemeExtension<BluetoothDeviceDetailsTileTheme>
    with _$BluetoothDeviceDetailsTileThemeTailorMixin {
  @override
  final IconData classicIcon;
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
  final IconData highSpeedIcon;
  @override
  final IconData inSystemIcon;
  @override
  final IconData lowPowerIcon;
  @override
  final IconData nullRssiIcon;
  @override
  final IconData pairedIcon;
  @override
  final Color selectedColor;
  @override
  final Color typeIconColor;
  @override
  final IconData unpairedIcon;

  const BluetoothDeviceDetailsTileTheme({
    required this.classicIcon,
    required this.connectedColor,
    required this.connectedIcon,
    required this.disconnectedColor,
    required this.disconnectedIcon,
    required this.highlightColor,
    required this.highSpeedIcon,
    required this.inSystemIcon,
    required this.lowPowerIcon,
    required this.nullRssiIcon,
    required this.pairedIcon,
    required this.selectedColor,
    required this.typeIconColor,
    required this.unpairedIcon,
  });

  Gradient brandGradient({
    required bool isSelected,
    required bool isConnected,
  }) {
    final leadColor = isSelected
        ? selectedColor
        : (isConnected ? connectedColor : disconnectedColor);
    final tailColor = isConnected ? connectedColor : disconnectedColor;
    return LinearGradient(
      colors: [leadColor, Color.lerp(leadColor, tailColor, 0.5)!, tailColor],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}

/// **Requirements:**
/// - [BluetoothDevice]
///
/// **Themes:**
/// - [BluetoothDeviceDetailsTileTheme]
class BluetoothDeviceDetailsTile extends StatelessWidget {
  const BluetoothDeviceDetailsTile({super.key});

  @override
  Widget build(BuildContext context) {
    final rssiText = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final themeExtension = themeData
            .extension<BluetoothDeviceDetailsTileTheme>();

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

    final togglePairingButton = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final themeExtension = themeData
            .extension<BluetoothDeviceDetailsTileTheme>();
        final highlightColor = themeExtension?.highlightColor;
        final isPaired = context.select<BluetoothDevice, bool>(
          (device) => device.isPaired,
        );
        final togglePairing = context.select<BluetoothDevice, VoidCallback?>(
          (device) => device.togglePairing,
        );
        final iconData = (isPaired)
            ? themeExtension?.unpairedIcon
            : themeExtension?.pairedIcon;
        final icon = Icon(iconData);
        final color = themeData.textTheme.bodyMedium?.color;
        return IconButton(
          color: color,
          highlightColor: highlightColor,
          icon: icon,
          onPressed: togglePairing,
        );
      },
    );

    final toggleConnectionButton = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final themeExtension = themeData
            .extension<BluetoothDeviceDetailsTileTheme>();
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

    final typeIconList = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final themeExtension = themeData
            .extension<BluetoothDeviceDetailsTileTheme>();
        final vaildIcons = <IconData?, bool>{};
        final inSystem = context.select<BluetoothDevice, bool>(
          (device) => device.inSystem,
        );
        vaildIcons[themeExtension?.inSystemIcon] = inSystem;
        final tech = context.select<BluetoothDevice, BluetoothTech>(
          (device) => device.tech,
        );
        switch (tech) {
          case BluetoothTech.unknown:
            break;
          case BluetoothTech.classic:
            vaildIcons[themeExtension?.classicIcon] = true;
            break;
          case BluetoothTech.highSpeed:
            vaildIcons[themeExtension?.highSpeedIcon] = true;
            break;
          case BluetoothTech.lowEnergy:
            vaildIcons[themeExtension?.lowPowerIcon] = true;
            break;
        }
        final iconTheme = IconTheme.of(context);
        final tentativeIconSize = iconTheme.size ?? kDefaultFontSize;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(vaildIcons.length ~/ 2, (n) {
            final list = vaildIcons.entries.skip(n * 2).take(2);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(list.length, (index) {
                final backgroundColor = themeData.textTheme.bodyMedium?.color;
                final color = (list.elementAt(index).value)
                    ? themeExtension?.typeIconColor
                    : null;
                return Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    list.elementAt(index).key,
                    size: tentativeIconSize - 2,
                    color: color,
                  ),
                );
              }),
            );
          }),
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
          typeIconList,
          togglePairingButton,
          toggleConnectionButton,
        ],
      ),
    );

    return Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final themeExtension = themeData
            .extension<BluetoothDeviceDetailsTileTheme>();

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
        final brandGradient = themeExtension?.brandGradient(
          isSelected: isSelected,
          isConnected: isConnected,
        );
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
