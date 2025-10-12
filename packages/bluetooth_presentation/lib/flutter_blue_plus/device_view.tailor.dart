// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_view.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$CharacteristicTileThemeTailorMixin
    on ThemeExtension<CharacteristicTileTheme> {
  Color get titleColor;

  @override
  CharacteristicTileTheme copyWith({Color? titleColor}) {
    return CharacteristicTileTheme(titleColor: titleColor ?? this.titleColor);
  }

  @override
  CharacteristicTileTheme lerp(
    covariant ThemeExtension<CharacteristicTileTheme>? other,
    double t,
  ) {
    if (other is! CharacteristicTileTheme)
      return this as CharacteristicTileTheme;
    return CharacteristicTileTheme(
      titleColor: Color.lerp(titleColor, other.titleColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CharacteristicTileTheme &&
            const DeepCollectionEquality().equals(
              titleColor,
              other.titleColor,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(titleColor),
    );
  }
}

extension CharacteristicTileThemeBuildContextProps on BuildContext {
  CharacteristicTileTheme get characteristicTileTheme =>
      Theme.of(this).extension<CharacteristicTileTheme>()!;
  Color get titleColor => characteristicTileTheme.titleColor;
}

mixin _$DescriptorTileThemeTailorMixin on ThemeExtension<DescriptorTileTheme> {
  Color get titleColor;

  @override
  DescriptorTileTheme copyWith({Color? titleColor}) {
    return DescriptorTileTheme(titleColor: titleColor ?? this.titleColor);
  }

  @override
  DescriptorTileTheme lerp(
    covariant ThemeExtension<DescriptorTileTheme>? other,
    double t,
  ) {
    if (other is! DescriptorTileTheme) return this as DescriptorTileTheme;
    return DescriptorTileTheme(
      titleColor: Color.lerp(titleColor, other.titleColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DescriptorTileTheme &&
            const DeepCollectionEquality().equals(
              titleColor,
              other.titleColor,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(titleColor),
    );
  }
}

extension DescriptorTileThemeBuildContextProps on BuildContext {
  DescriptorTileTheme get descriptorTileTheme =>
      Theme.of(this).extension<DescriptorTileTheme>()!;
  Color get titleColor => descriptorTileTheme.titleColor;
}

mixin _$ServiceTileThemeTailorMixin on ThemeExtension<ServiceTileTheme> {
  Color get titleColor;

  @override
  ServiceTileTheme copyWith({Color? titleColor}) {
    return ServiceTileTheme(titleColor: titleColor ?? this.titleColor);
  }

  @override
  ServiceTileTheme lerp(
    covariant ThemeExtension<ServiceTileTheme>? other,
    double t,
  ) {
    if (other is! ServiceTileTheme) return this as ServiceTileTheme;
    return ServiceTileTheme(
      titleColor: Color.lerp(titleColor, other.titleColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServiceTileTheme &&
            const DeepCollectionEquality().equals(
              titleColor,
              other.titleColor,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(titleColor),
    );
  }
}

extension ServiceTileThemeBuildContextProps on BuildContext {
  ServiceTileTheme get serviceTileTheme =>
      Theme.of(this).extension<ServiceTileTheme>()!;
  Color get titleColor => serviceTileTheme.titleColor;
}
