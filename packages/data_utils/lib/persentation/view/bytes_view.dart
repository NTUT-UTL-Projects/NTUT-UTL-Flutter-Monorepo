import 'package:flutter/material.dart';

Iterable<String> _toByteStrings(List<int> bytes, {bool upperCase = true}) sync* {
  for (final byte in bytes) {
    final hex = byte.toRadixString(16).padLeft(2, '0');
    yield upperCase ? hex.toUpperCase() : hex;
  }
}

@immutable
class BytesTheme extends ThemeExtension<BytesTheme> {
  const BytesTheme({
    this.colorCycle = const [Colors.red, Colors.green],
    this.indexColor = Colors.grey,
  });

  final List<Color?> colorCycle;
  final Color indexColor;

  @override
  BytesTheme copyWith({
    List<Color?>? valueColorCycle,
    Color? valueIndexColor,
    int? maxValueRowLength,
  }) => BytesTheme(
        colorCycle: valueColorCycle ?? this.colorCycle,
        indexColor: valueIndexColor ?? this.indexColor,
      );

  @override
  BytesTheme lerp(ThemeExtension<BytesTheme>? other, double t) {
    if (other is! BytesTheme) return this;
    return BytesTheme(
      colorCycle: List.generate(colorCycle.length, (index) {
        return Color.lerp(
          colorCycle.elementAt(index),
          other.colorCycle.elementAt(index),
          t,
        ) ??
        colorCycle.elementAt(index);
      }),
      indexColor: Color.lerp(
          indexColor as Color?,
          other.indexColor as Color?,
          t,
        ) ??
        indexColor,
    );
  }
}

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
    final themeExtension = themeData.extension<BytesTheme>()!;
    final lines = Iterable.generate((bytes.length / rowLength).ceil(), (i) {
      return _toByteStrings(bytes.skip(i * rowLength).take(rowLength).toList());
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...lines.indexed.map((line) {
          return Row(
            children: [
              if(showIndex)
                Text(
                  "${line.$1.toString().padLeft(2, '0')}. ",
                  style: TextStyle(fontSize: 13, color: themeExtension.indexColor),
                ),
              ...line.$2.indexed.map((b) {
                Color? color = (themeExtension.colorCycle.isNotEmpty)
                  ? themeExtension.colorCycle[b.$1 % themeExtension.colorCycle.length]
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
