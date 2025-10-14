// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seat_cushion_force_color_bar.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$SeatCushionForceColorBarThemeTailorMixin
    on ThemeExtension<SeatCushionForceColorBarTheme> {
  Color Function(double) get forceToColor;

  @override
  SeatCushionForceColorBarTheme copyWith({
    Color Function(double)? forceToColor,
  }) {
    return SeatCushionForceColorBarTheme(
      forceToColor: forceToColor ?? this.forceToColor,
    );
  }

  @override
  SeatCushionForceColorBarTheme lerp(
    covariant ThemeExtension<SeatCushionForceColorBarTheme>? other,
    double t,
  ) {
    if (other is! SeatCushionForceColorBarTheme)
      return this as SeatCushionForceColorBarTheme;
    return SeatCushionForceColorBarTheme(
      forceToColor: t < 0.5 ? forceToColor : other.forceToColor,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SeatCushionForceColorBarTheme &&
            const DeepCollectionEquality().equals(
              forceToColor,
              other.forceToColor,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(forceToColor),
    );
  }
}

extension SeatCushionForceColorBarThemeBuildContextProps on BuildContext {
  SeatCushionForceColorBarTheme get seatCushionForceColorBarTheme =>
      Theme.of(this).extension<SeatCushionForceColorBarTheme>()!;
  Color Function(double) get forceToColor =>
      seatCushionForceColorBarTheme.forceToColor;
}
