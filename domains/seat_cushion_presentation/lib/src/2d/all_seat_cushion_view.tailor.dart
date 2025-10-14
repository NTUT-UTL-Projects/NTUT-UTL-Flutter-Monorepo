// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_seat_cushion_view.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$SeatCushionForceWidgetThemeTailorMixin
    on ThemeExtension<SeatCushionForceWidgetTheme> {
  Color get borderColor;
  Color Function(double) get forceToColor;

  @override
  SeatCushionForceWidgetTheme copyWith({
    Color? borderColor,
    Color Function(double)? forceToColor,
  }) {
    return SeatCushionForceWidgetTheme(
      borderColor: borderColor ?? this.borderColor,
      forceToColor: forceToColor ?? this.forceToColor,
    );
  }

  @override
  SeatCushionForceWidgetTheme lerp(
    covariant ThemeExtension<SeatCushionForceWidgetTheme>? other,
    double t,
  ) {
    if (other is! SeatCushionForceWidgetTheme)
      return this as SeatCushionForceWidgetTheme;
    return SeatCushionForceWidgetTheme(
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      forceToColor: t < 0.5 ? forceToColor : other.forceToColor,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SeatCushionForceWidgetTheme &&
            const DeepCollectionEquality().equals(
              borderColor,
              other.borderColor,
            ) &&
            const DeepCollectionEquality().equals(
              forceToColor,
              other.forceToColor,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(borderColor),
      const DeepCollectionEquality().hash(forceToColor),
    );
  }
}

extension SeatCushionForceWidgetThemeBuildContextProps on BuildContext {
  SeatCushionForceWidgetTheme get seatCushionForceWidgetTheme =>
      Theme.of(this).extension<SeatCushionForceWidgetTheme>()!;
  Color get borderColor => seatCushionForceWidgetTheme.borderColor;
  Color Function(double) get forceToColor =>
      seatCushionForceWidgetTheme.forceToColor;
}

mixin _$SeatCushionIschiumPointWidgetThemeTailorMixin
    on ThemeExtension<SeatCushionIschiumPointWidgetTheme> {
  Color get borderColor;
  Color get ischiumColor;

  @override
  SeatCushionIschiumPointWidgetTheme copyWith({
    Color? borderColor,
    Color? ischiumColor,
  }) {
    return SeatCushionIschiumPointWidgetTheme(
      borderColor: borderColor ?? this.borderColor,
      ischiumColor: ischiumColor ?? this.ischiumColor,
    );
  }

  @override
  SeatCushionIschiumPointWidgetTheme lerp(
    covariant ThemeExtension<SeatCushionIschiumPointWidgetTheme>? other,
    double t,
  ) {
    if (other is! SeatCushionIschiumPointWidgetTheme)
      return this as SeatCushionIschiumPointWidgetTheme;
    return SeatCushionIschiumPointWidgetTheme(
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      ischiumColor: Color.lerp(ischiumColor, other.ischiumColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SeatCushionIschiumPointWidgetTheme &&
            const DeepCollectionEquality().equals(
              borderColor,
              other.borderColor,
            ) &&
            const DeepCollectionEquality().equals(
              ischiumColor,
              other.ischiumColor,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(borderColor),
      const DeepCollectionEquality().hash(ischiumColor),
    );
  }
}

extension SeatCushionIschiumPointWidgetThemeBuildContextProps on BuildContext {
  SeatCushionIschiumPointWidgetTheme get seatCushionIschiumPointWidgetTheme =>
      Theme.of(this).extension<SeatCushionIschiumPointWidgetTheme>()!;
  Color get borderColor => seatCushionIschiumPointWidgetTheme.borderColor;
  Color get ischiumColor => seatCushionIschiumPointWidgetTheme.ischiumColor;
}
