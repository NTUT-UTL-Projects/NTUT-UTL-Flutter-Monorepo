part of '../device_view.dart';

@immutable
@TailorMixin()
class ServiceTileTheme extends ThemeExtension<ServiceTileTheme>
    with _$ServiceTileThemeTailorMixin {
  @override
  final Color titleColor;
  
  const ServiceTileTheme({
    required this.titleColor,
  });
}

/// **Requirements:**
/// - [BluetoothService]
///
/// **Themes:**
/// - [ServiceTileTheme]
/// - [TextTheme]
class ServiceTile extends StatelessWidget {
  /// It provide the [BluetoothCharacteristic].
  final Widget? characteristicTile;

  const ServiceTile({super.key, this.characteristicTile});

  @override
  Widget build(BuildContext context) {
    final titleText = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final themeExtension = themeData.extension<ServiceTileTheme>();
        return Text(
          'Service',
          style: themeData.textTheme.titleMedium?.copyWith(
            color: themeExtension?.titleColor,
          ),
        );
      },
    );

    final uuidText = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final uuid = context.select<BluetoothService, Guid>((s) => s.uuid);
        return Text(
          uuid.str.toUpperCase(),
          style: themeData.textTheme.bodySmall,
        );
      },
    );

    return Builder(
      builder: (context) {
        final length = context.select<BluetoothService, int>(
          (s) => s.characteristics.length,
        );
        return (length > 0)
            ? ExpansionTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[titleText, uuidText],
                ),
                children: List.generate(length, (index) {
                  return ProxyProvider<
                    BluetoothService,
                    BluetoothCharacteristic
                  >(
                    update: (_, service, __) =>
                        service.characteristics.elementAt(index),
                    child: characteristicTile,
                  );
                }),
              )
              : ListTile(
                title: titleText,
                subtitle: uuidText,
              );
      },
    );
  }
}
