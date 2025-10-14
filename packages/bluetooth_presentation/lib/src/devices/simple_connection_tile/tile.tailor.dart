// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tile.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$BluetoothDeviceSimpleConnectionTileThemeTailorMixin
    on ThemeExtension<BluetoothDeviceSimpleConnectionTileTheme> {
  Color get connectedColor;
  IconData get connectedIcon;
  Color get disconnectedColor;
  IconData get disconnectedIcon;
  Color get highlightColor;
  IconData get nullRssiIcon;
  Color get selectedColor;

  @override
  BluetoothDeviceSimpleConnectionTileTheme copyWith({
    Color? connectedColor,
    IconData? connectedIcon,
    Color? disconnectedColor,
    IconData? disconnectedIcon,
    Color? highlightColor,
    IconData? nullRssiIcon,
    Color? selectedColor,
  }) {
    return BluetoothDeviceSimpleConnectionTileTheme(
      connectedColor: connectedColor ?? this.connectedColor,
      connectedIcon: connectedIcon ?? this.connectedIcon,
      disconnectedColor: disconnectedColor ?? this.disconnectedColor,
      disconnectedIcon: disconnectedIcon ?? this.disconnectedIcon,
      highlightColor: highlightColor ?? this.highlightColor,
      nullRssiIcon: nullRssiIcon ?? this.nullRssiIcon,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }

  @override
  BluetoothDeviceSimpleConnectionTileTheme lerp(
    covariant ThemeExtension<BluetoothDeviceSimpleConnectionTileTheme>? other,
    double t,
  ) {
    if (other is! BluetoothDeviceSimpleConnectionTileTheme)
      return this as BluetoothDeviceSimpleConnectionTileTheme;
    return BluetoothDeviceSimpleConnectionTileTheme(
      connectedColor: Color.lerp(connectedColor, other.connectedColor, t)!,
      connectedIcon: t < 0.5 ? connectedIcon : other.connectedIcon,
      disconnectedColor: Color.lerp(
        disconnectedColor,
        other.disconnectedColor,
        t,
      )!,
      disconnectedIcon: t < 0.5 ? disconnectedIcon : other.disconnectedIcon,
      highlightColor: Color.lerp(highlightColor, other.highlightColor, t)!,
      nullRssiIcon: t < 0.5 ? nullRssiIcon : other.nullRssiIcon,
      selectedColor: Color.lerp(selectedColor, other.selectedColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BluetoothDeviceSimpleConnectionTileTheme &&
            const DeepCollectionEquality().equals(
              connectedColor,
              other.connectedColor,
            ) &&
            const DeepCollectionEquality().equals(
              connectedIcon,
              other.connectedIcon,
            ) &&
            const DeepCollectionEquality().equals(
              disconnectedColor,
              other.disconnectedColor,
            ) &&
            const DeepCollectionEquality().equals(
              disconnectedIcon,
              other.disconnectedIcon,
            ) &&
            const DeepCollectionEquality().equals(
              highlightColor,
              other.highlightColor,
            ) &&
            const DeepCollectionEquality().equals(
              nullRssiIcon,
              other.nullRssiIcon,
            ) &&
            const DeepCollectionEquality().equals(
              selectedColor,
              other.selectedColor,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(connectedColor),
      const DeepCollectionEquality().hash(connectedIcon),
      const DeepCollectionEquality().hash(disconnectedColor),
      const DeepCollectionEquality().hash(disconnectedIcon),
      const DeepCollectionEquality().hash(highlightColor),
      const DeepCollectionEquality().hash(nullRssiIcon),
      const DeepCollectionEquality().hash(selectedColor),
    );
  }
}

extension BluetoothDeviceSimpleConnectionTileThemeBuildContextProps
    on BuildContext {
  BluetoothDeviceSimpleConnectionTileTheme
  get bluetoothDeviceSimpleConnectionTileTheme =>
      Theme.of(this).extension<BluetoothDeviceSimpleConnectionTileTheme>()!;
  Color get connectedColor =>
      bluetoothDeviceSimpleConnectionTileTheme.connectedColor;
  IconData get connectedIcon =>
      bluetoothDeviceSimpleConnectionTileTheme.connectedIcon;
  Color get disconnectedColor =>
      bluetoothDeviceSimpleConnectionTileTheme.disconnectedColor;
  IconData get disconnectedIcon =>
      bluetoothDeviceSimpleConnectionTileTheme.disconnectedIcon;
  Color get highlightColor =>
      bluetoothDeviceSimpleConnectionTileTheme.highlightColor;
  IconData get nullRssiIcon =>
      bluetoothDeviceSimpleConnectionTileTheme.nullRssiIcon;
  Color get selectedColor =>
      bluetoothDeviceSimpleConnectionTileTheme.selectedColor;
}
