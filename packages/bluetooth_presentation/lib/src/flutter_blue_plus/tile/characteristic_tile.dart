part of '../device_view.dart';

@immutable
@TailorMixin()
class CharacteristicTileTheme extends ThemeExtension<CharacteristicTileTheme>
    with _$CharacteristicTileThemeTailorMixin {
  @override
  final Color titleColor;
  
  const CharacteristicTileTheme({
    required this.titleColor,
  });
}

/// **Requirements:**
/// - [BluetoothCharacteristic]
///
/// **Themes:**
/// - [CharacteristicTileTheme]
/// - [TextTheme]
class CharacteristicTile extends StatelessWidget {
  /// It provide the [BluetoothDescriptor].
  final Widget? descriptorTile;

  final List<int> Function()? writeValueGetter;

  /// It provide the `List<int>`.
  final Widget? valueTile;

  const CharacteristicTile({
    super.key,
    this.descriptorTile,
    this.writeValueGetter,
    this.valueTile,
  });

  @override
  Widget build(BuildContext context) {
    final titleText = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final themeExtension = themeData.extension<CharacteristicTileTheme>();
        return Text(
          'Characteristic',
          style: themeData.textTheme.titleMedium?.copyWith(
            color: themeExtension?.titleColor,
          ),
        );
      },
    );

    final uuidText = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final uuid = context.select<BluetoothCharacteristic, Guid>(
          (c) => c.uuid,
        );
        final instanceId = context.select<BluetoothCharacteristic, int>(
          (c) => c.instanceId,
        );
        return Text(
          "${uuid.str.toUpperCase()} ($instanceId)",
          style: themeData.textTheme.bodySmall,
        );
      },
    );

    final valueField = Builder(
      builder: (context) {
        final lastValueStream = context
            .select<BluetoothCharacteristic, Stream<List<int>>>(
              (c) => c.lastValueStream,
            );
        return StreamProvider(
          create: (_) => lastValueStream,
          initialData: null,
          child: valueTile,
        );
      },
    );

    final readButton = Builder(
      builder: (context) {
        final canRead = context.select<BluetoothCharacteristic, bool>(
          (c) => c.properties.read,
        );
        final characteristic = context.watch<BluetoothCharacteristic>();
        return (canRead)
            ? TextButton(
                onPressed: () async {
                  try {
                    await characteristic.read();
                  } catch (e) {}
                },
                child: const Text("Read"),
              )
            : Column();
      },
    );

    final writeButton = Builder(
      builder: (context) {
        final write = context.select<BluetoothCharacteristic, bool>(
          (c) => c.properties.write,
        );
        final writeWithoutResponse = context
            .select<BluetoothCharacteristic, bool>(
              (c) => c.properties.writeWithoutResponse,
            );
        final characteristic = context.watch<BluetoothCharacteristic>();
        return (write || writeWithoutResponse)
            ? TextButton(
                onPressed: () async {
                  try {
                    await characteristic.write(writeValueGetter?.call() ?? []);
                  } catch(e) {}
                },
                child: Text(
                  writeWithoutResponse
                  ? "WriteNoResp"
                  : "Write",
                ),
              )
            : Column();
      },
    );

    final notifyButton = Builder(
      builder: (context) {
        final canNotify = context.select<BluetoothCharacteristic, bool>(
          (c) => c.properties.notify || c.properties.indicate,
        );
        if (canNotify) {
          final characteristic = context.watch<BluetoothCharacteristic>();
          return StreamProvider<bool>(
            create: (_) => characteristic.onNotifyValueChanged,
            initialData: characteristic.isNotifying,
            child: Builder(
              builder: (context) {
                final isNotifying = context.watch<bool>();
                return TextButton(
                  onPressed: () async {
                    try {
                      await characteristic.setNotifyValue(!isNotifying);
                    } catch (e) {}
                  },
                  child: Text(
                    isNotifying
                    ? "Unsubscribe"
                    : "Subscribe",
                  ),
                );
              },
            ),
          );
        } else {
          return Column();
        }
      },
    );

    return Builder(
      builder: (context) {
        final length = context.select<BluetoothCharacteristic, int>(
          (c) => c.descriptors.length,
        );
        return ExpansionTile(
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleText,
                uuidText,
                const Divider(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    readButton,
                    writeButton,
                    notifyButton,
                  ],
                ),
                valueField,
              ],
            ),
          ),
          children: List.generate(
            length,
            (index) {
              return ProxyProvider<BluetoothCharacteristic, BluetoothDescriptor>(
                update: (_, characteristics, __) => characteristics.descriptors.elementAt(index),
                child: descriptorTile,
              );
            },
          ),
        );
      },
    );
  }
}
