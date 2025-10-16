// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seat_cushion_features_line.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$SeatCushionFeaturesLineThemeTailorMixin
    on ThemeExtension<SeatCushionFeaturesLineTheme> {
  Color get clearColor;
  IconData get clearIcon;
  Color get downloadColor;
  IconData get downloadIcon;
  Color get recordColor;
  IconData get recordIcon;

  @override
  SeatCushionFeaturesLineTheme copyWith({
    Color? clearColor,
    IconData? clearIcon,
    Color? downloadColor,
    IconData? downloadIcon,
    Color? recordColor,
    IconData? recordIcon,
  }) {
    return SeatCushionFeaturesLineTheme(
      clearColor: clearColor ?? this.clearColor,
      clearIcon: clearIcon ?? this.clearIcon,
      downloadColor: downloadColor ?? this.downloadColor,
      downloadIcon: downloadIcon ?? this.downloadIcon,
      recordColor: recordColor ?? this.recordColor,
      recordIcon: recordIcon ?? this.recordIcon,
    );
  }

  @override
  SeatCushionFeaturesLineTheme lerp(
    covariant ThemeExtension<SeatCushionFeaturesLineTheme>? other,
    double t,
  ) {
    if (other is! SeatCushionFeaturesLineTheme)
      return this as SeatCushionFeaturesLineTheme;
    return SeatCushionFeaturesLineTheme(
      clearColor: Color.lerp(clearColor, other.clearColor, t)!,
      clearIcon: t < 0.5 ? clearIcon : other.clearIcon,
      downloadColor: Color.lerp(downloadColor, other.downloadColor, t)!,
      downloadIcon: t < 0.5 ? downloadIcon : other.downloadIcon,
      recordColor: Color.lerp(recordColor, other.recordColor, t)!,
      recordIcon: t < 0.5 ? recordIcon : other.recordIcon,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SeatCushionFeaturesLineTheme &&
            const DeepCollectionEquality().equals(
              clearColor,
              other.clearColor,
            ) &&
            const DeepCollectionEquality().equals(clearIcon, other.clearIcon) &&
            const DeepCollectionEquality().equals(
              downloadColor,
              other.downloadColor,
            ) &&
            const DeepCollectionEquality().equals(
              downloadIcon,
              other.downloadIcon,
            ) &&
            const DeepCollectionEquality().equals(
              recordColor,
              other.recordColor,
            ) &&
            const DeepCollectionEquality().equals(
              recordIcon,
              other.recordIcon,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(clearColor),
      const DeepCollectionEquality().hash(clearIcon),
      const DeepCollectionEquality().hash(downloadColor),
      const DeepCollectionEquality().hash(downloadIcon),
      const DeepCollectionEquality().hash(recordColor),
      const DeepCollectionEquality().hash(recordIcon),
    );
  }
}

extension SeatCushionFeaturesLineThemeBuildContextProps on BuildContext {
  SeatCushionFeaturesLineTheme get seatCushionFeaturesLineTheme =>
      Theme.of(this).extension<SeatCushionFeaturesLineTheme>()!;
  Color get clearColor => seatCushionFeaturesLineTheme.clearColor;
  IconData get clearIcon => seatCushionFeaturesLineTheme.clearIcon;
  Color get downloadColor => seatCushionFeaturesLineTheme.downloadColor;
  IconData get downloadIcon => seatCushionFeaturesLineTheme.downloadIcon;
  Color get recordColor => seatCushionFeaturesLineTheme.recordColor;
  IconData get recordIcon => seatCushionFeaturesLineTheme.recordIcon;
}
