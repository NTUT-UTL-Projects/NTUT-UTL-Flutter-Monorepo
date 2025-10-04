part of '../device_view.dart';

class ServiceTile extends StatelessWidget {
  final Widget? characteristicTile;

  const ServiceTile({super.key, this.characteristicTile});

  @override
  Widget build(BuildContext context) {

    final titleText = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        return Text(
          'Service',
          style: themeData.textTheme.titleMedium?.copyWith(
            color: Colors.blue,
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
        final length = context.select<BluetoothService, int>((s) => s.characteristics.length);
        return (length > 0)
          ? ExpansionTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                titleText,
                uuidText,
              ],
            ),
            children: List.generate(
              length,
              (index) {
                return ProxyProvider<BluetoothService, BluetoothCharacteristic>(
                  update: (_, service, __) => service.characteristics.elementAt(index),
                  child: characteristicTile,
                );
              },
            ),
          )
          : ListTile(
            title: titleText,
            subtitle: uuidText,
          );
      },
    );
  }
}
