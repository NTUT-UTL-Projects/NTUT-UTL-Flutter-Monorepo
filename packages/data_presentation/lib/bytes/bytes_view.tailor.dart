// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bytes_view.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$BytesThemeTailorMixin on ThemeExtension<BytesTheme> {
  List<Color> get colorCycle;
  Color get indexColor;

  @override
  BytesTheme copyWith({List<Color>? colorCycle, Color? indexColor}) {
    return BytesTheme(
      colorCycle: colorCycle ?? this.colorCycle,
      indexColor: indexColor ?? this.indexColor,
    );
  }

  @override
  BytesTheme lerp(covariant ThemeExtension<BytesTheme>? other, double t) {
    if (other is! BytesTheme) return this as BytesTheme;
    return BytesTheme(
      colorCycle: t < 0.5 ? colorCycle : other.colorCycle,
      indexColor: Color.lerp(indexColor, other.indexColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BytesTheme &&
            const DeepCollectionEquality().equals(
              colorCycle,
              other.colorCycle,
            ) &&
            const DeepCollectionEquality().equals(
              indexColor,
              other.indexColor,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(colorCycle),
      const DeepCollectionEquality().hash(indexColor),
    );
  }
}

extension BytesThemeBuildContextProps on BuildContext {
  BytesTheme get bytesTheme => Theme.of(this).extension<BytesTheme>()!;
  List<Color> get colorCycle => bytesTheme.colorCycle;
  Color get indexColor => bytesTheme.indexColor;
}
