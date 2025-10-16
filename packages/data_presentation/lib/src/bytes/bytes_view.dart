import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'bytes_view.tailor.dart';

Iterable<String> _toByteStrings(
  List<int> bytes, {
  bool upperCase = true,
}) sync* {
  for (final byte in bytes) {
    final hex = byte.toRadixString(16).padLeft(2, '0');
    yield upperCase ? hex.toUpperCase() : hex;
  }
}

@immutable
@TailorMixin()
class BytesTheme extends ThemeExtension<BytesTheme>
    with _$BytesThemeTailorMixin {
  @override
  final List<Color> colorCycle;
  @override
  final Color indexColor;

  const BytesTheme({
    required this.colorCycle,
    required this.indexColor,
  });
}

/// **Theme**
/// - [BytesTheme]
class BytesView extends StatelessWidget {
  final List<int> bytes;
  final int rowLength;
  final bool showIndex;
  const BytesView({
    super.key,
    required this.bytes,
    this.rowLength = 10,
    this.showIndex = true,
  });
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final themeExtension = themeData.extension<BytesTheme>();
    final lines = Iterable.generate((bytes.length / rowLength).ceil(), (i) {
      return _toByteStrings(bytes.skip(i * rowLength).take(rowLength).toList());
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...lines.indexed.map((line) {
          return Row(
            children: [
              if (showIndex)
                Text(
                  "${line.$1.toString().padLeft(2, '0')}. ",
                  style: TextStyle(
                    fontSize: 13,
                    color: themeExtension?.indexColor,
                  ),
                ),
              ...line.$2.indexed.map((b) {
                Color? color = (themeExtension?.colorCycle.isNotEmpty ?? false)
                    ? themeExtension?.colorCycle[b.$1 %
                          themeExtension.colorCycle.length]
                    : null;
                return Text(
                  b.$2,
                  style: TextStyle(
                    fontSize: 13,
                    color: color,
                  ),
                );
              }),
            ],
          );
        }),
      ],
    );
  }
}
