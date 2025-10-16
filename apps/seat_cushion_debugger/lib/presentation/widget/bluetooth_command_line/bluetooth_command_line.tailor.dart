// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bluetooth_command_line.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$BluetoothCommandLineThemeTailorMixin
    on ThemeExtension<BluetoothCommandLineTheme> {
  Color get clearColor;
  IconData get clearIcon;
  Color get initColor;
  IconData get initIcon;
  Color get sendColor;
  IconData get sendIcon;

  @override
  BluetoothCommandLineTheme copyWith({
    Color? clearColor,
    IconData? clearIcon,
    Color? initColor,
    IconData? initIcon,
    Color? sendColor,
    IconData? sendIcon,
  }) {
    return BluetoothCommandLineTheme(
      clearColor: clearColor ?? this.clearColor,
      clearIcon: clearIcon ?? this.clearIcon,
      initColor: initColor ?? this.initColor,
      initIcon: initIcon ?? this.initIcon,
      sendColor: sendColor ?? this.sendColor,
      sendIcon: sendIcon ?? this.sendIcon,
    );
  }

  @override
  BluetoothCommandLineTheme lerp(
    covariant ThemeExtension<BluetoothCommandLineTheme>? other,
    double t,
  ) {
    if (other is! BluetoothCommandLineTheme)
      return this as BluetoothCommandLineTheme;
    return BluetoothCommandLineTheme(
      clearColor: Color.lerp(clearColor, other.clearColor, t)!,
      clearIcon: t < 0.5 ? clearIcon : other.clearIcon,
      initColor: Color.lerp(initColor, other.initColor, t)!,
      initIcon: t < 0.5 ? initIcon : other.initIcon,
      sendColor: Color.lerp(sendColor, other.sendColor, t)!,
      sendIcon: t < 0.5 ? sendIcon : other.sendIcon,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BluetoothCommandLineTheme &&
            const DeepCollectionEquality().equals(
              clearColor,
              other.clearColor,
            ) &&
            const DeepCollectionEquality().equals(clearIcon, other.clearIcon) &&
            const DeepCollectionEquality().equals(initColor, other.initColor) &&
            const DeepCollectionEquality().equals(initIcon, other.initIcon) &&
            const DeepCollectionEquality().equals(sendColor, other.sendColor) &&
            const DeepCollectionEquality().equals(sendIcon, other.sendIcon));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(clearColor),
      const DeepCollectionEquality().hash(clearIcon),
      const DeepCollectionEquality().hash(initColor),
      const DeepCollectionEquality().hash(initIcon),
      const DeepCollectionEquality().hash(sendColor),
      const DeepCollectionEquality().hash(sendIcon),
    );
  }
}

extension BluetoothCommandLineThemeBuildContextProps on BuildContext {
  BluetoothCommandLineTheme get bluetoothCommandLineTheme =>
      Theme.of(this).extension<BluetoothCommandLineTheme>()!;
  Color get clearColor => bluetoothCommandLineTheme.clearColor;
  IconData get clearIcon => bluetoothCommandLineTheme.clearIcon;
  Color get initColor => bluetoothCommandLineTheme.initColor;
  IconData get initIcon => bluetoothCommandLineTheme.initIcon;
  Color get sendColor => bluetoothCommandLineTheme.sendColor;
  IconData get sendIcon => bluetoothCommandLineTheme.sendIcon;
}
