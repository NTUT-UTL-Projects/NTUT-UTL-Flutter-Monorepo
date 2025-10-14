// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hex_keyboard.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$HexKeyboardThemeTailorMixin on ThemeExtension<HexKeyboardTheme> {
  Color get backspaceColor;
  Color get clearColor;
  Color get submitColor;

  @override
  HexKeyboardTheme copyWith({
    Color? backspaceColor,
    Color? clearColor,
    Color? submitColor,
  }) {
    return HexKeyboardTheme(
      backspaceColor: backspaceColor ?? this.backspaceColor,
      clearColor: clearColor ?? this.clearColor,
      submitColor: submitColor ?? this.submitColor,
    );
  }

  @override
  HexKeyboardTheme lerp(
    covariant ThemeExtension<HexKeyboardTheme>? other,
    double t,
  ) {
    if (other is! HexKeyboardTheme) return this as HexKeyboardTheme;
    return HexKeyboardTheme(
      backspaceColor: Color.lerp(backspaceColor, other.backspaceColor, t)!,
      clearColor: Color.lerp(clearColor, other.clearColor, t)!,
      submitColor: Color.lerp(submitColor, other.submitColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HexKeyboardTheme &&
            const DeepCollectionEquality().equals(
              backspaceColor,
              other.backspaceColor,
            ) &&
            const DeepCollectionEquality().equals(
              clearColor,
              other.clearColor,
            ) &&
            const DeepCollectionEquality().equals(
              submitColor,
              other.submitColor,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(backspaceColor),
      const DeepCollectionEquality().hash(clearColor),
      const DeepCollectionEquality().hash(submitColor),
    );
  }
}

extension HexKeyboardThemeBuildContextProps on BuildContext {
  HexKeyboardTheme get hexKeyboardTheme =>
      Theme.of(this).extension<HexKeyboardTheme>()!;
  Color get backspaceColor => hexKeyboardTheme.backspaceColor;
  Color get clearColor => hexKeyboardTheme.clearColor;
  Color get submitColor => hexKeyboardTheme.submitColor;
}
