// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bluetooth_status_view.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$BluetoothStatusThemeTailorMixin
    on ThemeExtension<BluetoothStatusTheme> {
  Color get backGroundColor;
  Color get iconColor;
  Color get messageColor;

  @override
  BluetoothStatusTheme copyWith({
    Color? backGroundColor,
    Color? iconColor,
    Color? messageColor,
  }) {
    return BluetoothStatusTheme(
      backGroundColor: backGroundColor ?? this.backGroundColor,
      iconColor: iconColor ?? this.iconColor,
      messageColor: messageColor ?? this.messageColor,
    );
  }

  @override
  BluetoothStatusTheme lerp(
    covariant ThemeExtension<BluetoothStatusTheme>? other,
    double t,
  ) {
    if (other is! BluetoothStatusTheme) return this as BluetoothStatusTheme;
    return BluetoothStatusTheme(
      backGroundColor: Color.lerp(backGroundColor, other.backGroundColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      messageColor: Color.lerp(messageColor, other.messageColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BluetoothStatusTheme &&
            const DeepCollectionEquality().equals(
              backGroundColor,
              other.backGroundColor,
            ) &&
            const DeepCollectionEquality().equals(iconColor, other.iconColor) &&
            const DeepCollectionEquality().equals(
              messageColor,
              other.messageColor,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(backGroundColor),
      const DeepCollectionEquality().hash(iconColor),
      const DeepCollectionEquality().hash(messageColor),
    );
  }
}

extension BluetoothStatusThemeBuildContextProps on BuildContext {
  BluetoothStatusTheme get bluetoothStatusTheme =>
      Theme.of(this).extension<BluetoothStatusTheme>()!;
  Color get backGroundColor => bluetoothStatusTheme.backGroundColor;
  Color get iconColor => bluetoothStatusTheme.iconColor;
  Color get messageColor => bluetoothStatusTheme.messageColor;
}
