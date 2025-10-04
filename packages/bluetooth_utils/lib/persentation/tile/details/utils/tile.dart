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
  final IconData classic;
  final IconData connected;
  final IconData disconnected;
  final IconData highSpeed;
  final IconData inSystem;
  final IconData lowPower;
  final IconData nullRssi;
  final IconData paired;
  final IconData unpaired;

  BluetoothDeviceIcons({required this.classic, required this.connected, required this.disconnected, required this.highSpeed, required this.inSystem, required this.lowPower, required this.nullRssi, required this.paired, required this.unpaired});

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

    final togglePairingButton = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final themeExtension = themeData.extension<BluetoothDeviceTileTheme>()!;
        final highlightColor = themeExtension.highlightColor;
        final isPaired = context.select<BluetoothDevice, bool>((device) => device.isPaired);
        final togglePairing = context.select<BluetoothDevice, VoidCallback?>((device) => device.togglePairing);
        final iconData = (isPaired) 
          ? context.select<BluetoothDeviceIcons, IconData>(
            (i) => i.unpaired,
          )
          : context.select<BluetoothDeviceIcons, IconData>(
            (i) => i.paired,
          );
        final icon = Icon(
          iconData,
        );
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

    final iconList = Builder(
      builder: (context) {
        final icons = context.watch<BluetoothDeviceIcons>();
        final vaildIcons = <IconData, bool>{};
        final inSystem = context.select<BluetoothDevice, bool>((device) => device.inSystem);
        vaildIcons[icons.inSystem] = inSystem;
        final tech = context.select<BluetoothDevice, BluetoothTech>((device) => device.tech);
        switch(tech) {
          case BluetoothTech.unknown:
            break;
          case BluetoothTech.classic:
            vaildIcons[icons.classic] = true;
            break;
          case BluetoothTech.highSpeed:
            vaildIcons[icons.highSpeed] = true;
            break;
          case BluetoothTech.lowEnergy:
            vaildIcons[icons.lowPower] = true;
            break;
        }
        final themeData = Theme.of(context);
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
                  ? themeData.scaffoldBackgroundColor
                  : backgroundColor;
                return Container(
                  margin: EdgeInsets.all(2) ,
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
      }
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
          iconList,
          togglePairingButton,
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
