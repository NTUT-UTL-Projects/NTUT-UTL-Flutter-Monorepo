part of '../device_view.dart';

class DescriptorTile extends StatelessWidget {
  final List<int> Function()? valueGetter;
  final Widget? valueTile;

  const DescriptorTile({
    super.key,
    this.valueGetter,
    this.valueTile,
  });

  @override
  Widget build(BuildContext context) {

    final titleText = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        return Text(
          'Descriptor',
          style: themeData.textTheme.titleMedium?.copyWith(
            color: Colors.orange,
          ),
        );
      },
    );

    final uuidText = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final uuid = context.select<BluetoothDescriptor, Guid>((d) => d.uuid);
        return Text(
          uuid.str.toUpperCase(), 
          style: themeData.textTheme.bodySmall,
        );
      },
    );

    final valueField = Builder(
      builder: (context) {
        final lastValueStream = context.select<BluetoothDescriptor, Stream<List<int>>>((d) => d.lastValueStream);
        return StreamProvider(
          create: (_) => lastValueStream,
          initialData: null,
          child: valueTile ?? Column(),
        );
      },
    );

    final readButton = Builder(
      builder: (context) {
        final descriptor = context.watch<BluetoothDescriptor>();
        return TextButton(
          onPressed: () async {
            try {
              await descriptor.read();
            } catch(e) {}
          },
          child: const Text("Read"),
        );
      },
    );

    final writeButton = Builder(
      builder: (context) {
        final descriptor = context.watch<BluetoothDescriptor>();
        return TextButton(
          onPressed: () async {
            try {
              await descriptor.write(valueGetter?.call() ?? []);
            } catch(e) {}
          },
          child: Text("Write"),
        );
      },
    );

    return ListTile(
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
            ],
          ),
          valueField,
        ],
      ),
    );
  }
}
