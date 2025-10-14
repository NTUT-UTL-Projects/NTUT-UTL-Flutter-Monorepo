// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_seat_cushion_3d_mesh_widget.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AllSeatCushion3DMeshWidgetThemeTailorMixin
    on ThemeExtension<AllSeatCushion3DMeshWidgetTheme> {
  Color get baseColor;
  Color Function(SeatCushionUnitCornerPoint) get pointToColor;
  double Function(SeatCushionUnitCornerPoint) get pointToHeight;
  Color get strokeColor;

  @override
  AllSeatCushion3DMeshWidgetTheme copyWith({
    Color? baseColor,
    Color Function(SeatCushionUnitCornerPoint)? pointToColor,
    double Function(SeatCushionUnitCornerPoint)? pointToHeight,
    Color? strokeColor,
  }) {
    return AllSeatCushion3DMeshWidgetTheme(
      baseColor: baseColor ?? this.baseColor,
      pointToColor: pointToColor ?? this.pointToColor,
      pointToHeight: pointToHeight ?? this.pointToHeight,
      strokeColor: strokeColor ?? this.strokeColor,
    );
  }

  @override
  AllSeatCushion3DMeshWidgetTheme lerp(
    covariant ThemeExtension<AllSeatCushion3DMeshWidgetTheme>? other,
    double t,
  ) {
    if (other is! AllSeatCushion3DMeshWidgetTheme)
      return this as AllSeatCushion3DMeshWidgetTheme;
    return AllSeatCushion3DMeshWidgetTheme(
      baseColor: Color.lerp(baseColor, other.baseColor, t)!,
      pointToColor: t < 0.5 ? pointToColor : other.pointToColor,
      pointToHeight: t < 0.5 ? pointToHeight : other.pointToHeight,
      strokeColor: Color.lerp(strokeColor, other.strokeColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AllSeatCushion3DMeshWidgetTheme &&
            const DeepCollectionEquality().equals(baseColor, other.baseColor) &&
            const DeepCollectionEquality().equals(
              pointToColor,
              other.pointToColor,
            ) &&
            const DeepCollectionEquality().equals(
              pointToHeight,
              other.pointToHeight,
            ) &&
            const DeepCollectionEquality().equals(
              strokeColor,
              other.strokeColor,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(baseColor),
      const DeepCollectionEquality().hash(pointToColor),
      const DeepCollectionEquality().hash(pointToHeight),
      const DeepCollectionEquality().hash(strokeColor),
    );
  }
}

extension AllSeatCushion3DMeshWidgetThemeBuildContextProps on BuildContext {
  AllSeatCushion3DMeshWidgetTheme get allSeatCushion3DMeshWidgetTheme =>
      Theme.of(this).extension<AllSeatCushion3DMeshWidgetTheme>()!;

  /// The base fill color of the 3D mesh.
  Color get baseColor => allSeatCushion3DMeshWidgetTheme.baseColor;

  /// Maps a [SeatCushionUnitCornerPoint] (a single sensor corner point)
  ///
  /// to a specific [Color] for visualization.
  Color Function(SeatCushionUnitCornerPoint) get pointToColor =>
      allSeatCushion3DMeshWidgetTheme.pointToColor;

  /// Converts a [SeatCushionUnitCornerPoint] into a vertical displacement
  /// in the 3D mesh, defining the surface shape.
  double Function(SeatCushionUnitCornerPoint) get pointToHeight =>
      allSeatCushion3DMeshWidgetTheme.pointToHeight;

  /// The color used for stroke outlines or mesh grid lines.
  Color get strokeColor => allSeatCushion3DMeshWidgetTheme.strokeColor;
}
