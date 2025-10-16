part of '../device_view.dart';

@immutable
@TailorMixin()
class DescriptorTileTheme extends ThemeExtension<DescriptorTileTheme>
    with _$DescriptorTileThemeTailorMixin {
  @override
  final Color titleColor;
  
  const DescriptorTileTheme({
    required this.titleColor,
  });
}

/// **Requirements:**
/// - [BluetoothDescriptor]
///
/// **Themes:**
/// - [DescriptorTileTheme]
/// - [TextTheme]
class DescriptorTile extends StatelessWidget {
  final List<int> Function()? writeValueGetter;

  /// It provide the `List<int>`.
  final Widget? valueTile;

  const DescriptorTile({
    super.key,
    this.writeValueGetter,
    this.valueTile,
  });

  @override
  Widget build(BuildContext context) {
    final titleText = Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        final themeExtension = themeData.extension<DescriptorTileTheme>();
        return Text(
          'Descriptor',
          style: themeData.textTheme.titleMedium?.copyWith(
            color: themeExtension?.titleColor,
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
        final lastValueStream = context
            .select<BluetoothDescriptor, Stream<List<int>>>(
              (d) => d.lastValueStream,
            );
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
            } catch (e) {}
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
              await descriptor.write(writeValueGetter?.call() ?? []);
            } catch (e) {}
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
