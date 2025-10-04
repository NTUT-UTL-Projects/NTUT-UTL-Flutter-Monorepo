part of '../bluetooth_device_tile.dart';

@immutable
class BluetoothDeviceTileTheme extends ThemeExtension<BluetoothDeviceTileTheme> {
  const BluetoothDeviceTileTheme({
    required this.connectedColor,
    required this.disconnectedColor, 
    required this.highlightColor,
    required this.selectedColor,
  });

  final Color connectedColor;
  final Color disconnectedColor;
  final Color highlightColor;
  final Color selectedColor;

  Gradient brandGradient({
    required bool isSelected,
    required bool isConnected,
  }) {
    return LinearGradient(
      colors: [
        isSelected ? selectedColor : (isConnected ? connectedColor : disconnectedColor),
        isConnected ? connectedColor : disconnectedColor,
        isConnected ? connectedColor : disconnectedColor,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  @override
  BluetoothDeviceTileTheme copyWith({
    Color? connectedColor,
    Color? disconnectedColor,
    Color? highlightColor,
    Color? selectedColor,
  }) => BluetoothDeviceTileTheme(
        connectedColor: connectedColor ?? this.connectedColor,
        disconnectedColor: disconnectedColor ?? this.disconnectedColor,
        highlightColor: highlightColor ?? this.highlightColor,
        selectedColor: selectedColor ?? this.selectedColor,
      );

  @override
  BluetoothDeviceTileTheme lerp(ThemeExtension<BluetoothDeviceTileTheme>? other, double t) {
    if (other is! BluetoothDeviceTileTheme) return this;
    return BluetoothDeviceTileTheme(
      connectedColor: Color.lerp(
          connectedColor as Color?,
          other.connectedColor as Color?,
          t,
        ) ??
        connectedColor,
      disconnectedColor: Color.lerp(
          disconnectedColor as Color?,
          other.disconnectedColor as Color?,
          t,
        ) ??
        disconnectedColor,
      highlightColor: Color.lerp(
          highlightColor as Color?,
          other.highlightColor as Color?,
          t,
        ) ??
        highlightColor,
      selectedColor: Color.lerp(
          selectedColor as Color?,
          other.selectedColor as Color?,
          t,
        ) ??
        selectedColor,
    );
  }
}

class BluetoothDeviceIcons {
  final IconData connected;
  final IconData disconnected;
  final IconData nullRssi;

  BluetoothDeviceIcons({required this.connected, required this.disconnected, required this.nullRssi});

}

class BluetoothDeviceTile extends StatelessWidget {

  const BluetoothDeviceTile({
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    final rssiText = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final rssi = context.select<BluetoothDevice, int>(
          (device) => device.rssi,
        );
        final isScanned = context.select<BluetoothDevice, bool>(
          (device) => device.isScanned,
        );
        final nullRssi = context.select<BluetoothDeviceIcons, IconData>(
          (i) => i.nullRssi,
        );
        return (isScanned)
          ? Text(
              rssi.toString(),
              style: themeData.textTheme.bodyMedium,
            )
          : Icon(
              nullRssi,
              color: themeData.textTheme.bodyMedium?.color,
            );
      },
    );

    // Title section: if deviceName is available, show both name and ID
    // Otherwise, show only the deviceId
    final title = Builder(
      builder: (context) {
        final deviceId = context.select<BluetoothDevice, String>((device) => device.id);
        final deviceName = context.select<BluetoothDevice, String>((device) => device.name);
        return (deviceName != "")
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  deviceName,                // Display device name
                  overflow: TextOverflow.ellipsis, // Ellipsis if too long
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Builder(
                  builder: (context) {
                    return Text(
                      deviceId,               // Display device ID below name
                      style: Theme.of(context).textTheme.bodySmall,
                    );
                  },
                ),
              ],
            )
          : Text(deviceId); // Fallback to only deviceId if name is null
      },
    );

    final toggleConnectionButton = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final themeExtension = themeData.extension<BluetoothDeviceTileTheme>()!;
        final highlightColor = themeExtension.highlightColor;
        final isConnected = context.select<BluetoothDevice, bool>((device) => device.isConnected);
        final isConnectable = context.select<BluetoothDevice, bool>((device) => device.isConnectable);
        final toggleConnection = (isConnectable) 
          ? context.select<BluetoothDevice, VoidCallback?>((device) => device.toggleConnection)
          : null;
        final iconData = (isConnected) 
          ? context.select<BluetoothDeviceIcons, IconData>(
            (i) => i.disconnected,
          )
          : context.select<BluetoothDeviceIcons, IconData>(
            (i) => i.connected,
          );
        final icon = Icon(
          iconData,
        );
        final color = (isConnected)
          ? themeExtension.disconnectedColor
          :themeExtension.connectedColor;
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
        final isConnected = context.select<BluetoothDevice, bool>((device) => device.isConnected);
        final isSelected = context.select<BluetoothDevice, bool>((device) => device.isSelected);
        final onToggleSelection = context.select<BluetoothDevice, VoidCallback?>((device) => device.toggleSelection);
        final brandGradient = themeData.extension<BluetoothDeviceTileTheme>()!.brandGradient(
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
