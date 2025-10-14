// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tile.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$BluetoothDeviceDetailsTileThemeTailorMixin
    on ThemeExtension<BluetoothDeviceDetailsTileTheme> {
  IconData get classicIcon;
  Color get connectedColor;
  IconData get connectedIcon;
  Color get disconnectedColor;
  IconData get disconnectedIcon;
  Color get highlightColor;
  IconData get highSpeedIcon;
  IconData get inSystemIcon;
  IconData get lowPowerIcon;
  IconData get nullRssiIcon;
  IconData get pairedIcon;
  Color get selectedColor;
  Color get typeIconColor;
  IconData get unpairedIcon;

  @override
  BluetoothDeviceDetailsTileTheme copyWith({
    IconData? classicIcon,
    Color? connectedColor,
    IconData? connectedIcon,
    Color? disconnectedColor,
    IconData? disconnectedIcon,
    Color? highlightColor,
    IconData? highSpeedIcon,
    IconData? inSystemIcon,
    IconData? lowPowerIcon,
    IconData? nullRssiIcon,
    IconData? pairedIcon,
    Color? selectedColor,
    Color? typeIconColor,
    IconData? unpairedIcon,
  }) {
    return BluetoothDeviceDetailsTileTheme(
      classicIcon: classicIcon ?? this.classicIcon,
      connectedColor: connectedColor ?? this.connectedColor,
      connectedIcon: connectedIcon ?? this.connectedIcon,
      disconnectedColor: disconnectedColor ?? this.disconnectedColor,
      disconnectedIcon: disconnectedIcon ?? this.disconnectedIcon,
      highlightColor: highlightColor ?? this.highlightColor,
      highSpeedIcon: highSpeedIcon ?? this.highSpeedIcon,
      inSystemIcon: inSystemIcon ?? this.inSystemIcon,
      lowPowerIcon: lowPowerIcon ?? this.lowPowerIcon,
      nullRssiIcon: nullRssiIcon ?? this.nullRssiIcon,
      pairedIcon: pairedIcon ?? this.pairedIcon,
      selectedColor: selectedColor ?? this.selectedColor,
      typeIconColor: typeIconColor ?? this.typeIconColor,
      unpairedIcon: unpairedIcon ?? this.unpairedIcon,
    );
  }

  @override
  BluetoothDeviceDetailsTileTheme lerp(
    covariant ThemeExtension<BluetoothDeviceDetailsTileTheme>? other,
    double t,
  ) {
    if (other is! BluetoothDeviceDetailsTileTheme)
      return this as BluetoothDeviceDetailsTileTheme;
    return BluetoothDeviceDetailsTileTheme(
      classicIcon: t < 0.5 ? classicIcon : other.classicIcon,
      connectedColor: Color.lerp(connectedColor, other.connectedColor, t)!,
      connectedIcon: t < 0.5 ? connectedIcon : other.connectedIcon,
      disconnectedColor: Color.lerp(
        disconnectedColor,
        other.disconnectedColor,
        t,
      )!,
      disconnectedIcon: t < 0.5 ? disconnectedIcon : other.disconnectedIcon,
      highlightColor: Color.lerp(highlightColor, other.highlightColor, t)!,
      highSpeedIcon: t < 0.5 ? highSpeedIcon : other.highSpeedIcon,
      inSystemIcon: t < 0.5 ? inSystemIcon : other.inSystemIcon,
      lowPowerIcon: t < 0.5 ? lowPowerIcon : other.lowPowerIcon,
      nullRssiIcon: t < 0.5 ? nullRssiIcon : other.nullRssiIcon,
      pairedIcon: t < 0.5 ? pairedIcon : other.pairedIcon,
      selectedColor: Color.lerp(selectedColor, other.selectedColor, t)!,
      typeIconColor: Color.lerp(typeIconColor, other.typeIconColor, t)!,
      unpairedIcon: t < 0.5 ? unpairedIcon : other.unpairedIcon,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BluetoothDeviceDetailsTileTheme &&
            const DeepCollectionEquality().equals(
              classicIcon,
              other.classicIcon,
            ) &&
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
              highSpeedIcon,
              other.highSpeedIcon,
            ) &&
            const DeepCollectionEquality().equals(
              inSystemIcon,
              other.inSystemIcon,
            ) &&
            const DeepCollectionEquality().equals(
              lowPowerIcon,
              other.lowPowerIcon,
            ) &&
            const DeepCollectionEquality().equals(
              nullRssiIcon,
              other.nullRssiIcon,
            ) &&
            const DeepCollectionEquality().equals(
              pairedIcon,
              other.pairedIcon,
            ) &&
            const DeepCollectionEquality().equals(
              selectedColor,
              other.selectedColor,
            ) &&
            const DeepCollectionEquality().equals(
              typeIconColor,
              other.typeIconColor,
            ) &&
            const DeepCollectionEquality().equals(
              unpairedIcon,
              other.unpairedIcon,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(classicIcon),
      const DeepCollectionEquality().hash(connectedColor),
      const DeepCollectionEquality().hash(connectedIcon),
      const DeepCollectionEquality().hash(disconnectedColor),
      const DeepCollectionEquality().hash(disconnectedIcon),
      const DeepCollectionEquality().hash(highlightColor),
      const DeepCollectionEquality().hash(highSpeedIcon),
      const DeepCollectionEquality().hash(inSystemIcon),
      const DeepCollectionEquality().hash(lowPowerIcon),
      const DeepCollectionEquality().hash(nullRssiIcon),
      const DeepCollectionEquality().hash(pairedIcon),
      const DeepCollectionEquality().hash(selectedColor),
      const DeepCollectionEquality().hash(typeIconColor),
      const DeepCollectionEquality().hash(unpairedIcon),
    );
  }
}

extension BluetoothDeviceDetailsTileThemeBuildContextProps on BuildContext {
  BluetoothDeviceDetailsTileTheme get bluetoothDeviceDetailsTileTheme =>
      Theme.of(this).extension<BluetoothDeviceDetailsTileTheme>()!;
  IconData get classicIcon => bluetoothDeviceDetailsTileTheme.classicIcon;
  Color get connectedColor => bluetoothDeviceDetailsTileTheme.connectedColor;
  IconData get connectedIcon => bluetoothDeviceDetailsTileTheme.connectedIcon;
  Color get disconnectedColor =>
      bluetoothDeviceDetailsTileTheme.disconnectedColor;
  IconData get disconnectedIcon =>
      bluetoothDeviceDetailsTileTheme.disconnectedIcon;
  Color get highlightColor => bluetoothDeviceDetailsTileTheme.highlightColor;
  IconData get highSpeedIcon => bluetoothDeviceDetailsTileTheme.highSpeedIcon;
  IconData get inSystemIcon => bluetoothDeviceDetailsTileTheme.inSystemIcon;
  IconData get lowPowerIcon => bluetoothDeviceDetailsTileTheme.lowPowerIcon;
  IconData get nullRssiIcon => bluetoothDeviceDetailsTileTheme.nullRssiIcon;
  IconData get pairedIcon => bluetoothDeviceDetailsTileTheme.pairedIcon;
  Color get selectedColor => bluetoothDeviceDetailsTileTheme.selectedColor;
  Color get typeIconColor => bluetoothDeviceDetailsTileTheme.typeIconColor;
  IconData get unpairedIcon => bluetoothDeviceDetailsTileTheme.unpairedIcon;
}
