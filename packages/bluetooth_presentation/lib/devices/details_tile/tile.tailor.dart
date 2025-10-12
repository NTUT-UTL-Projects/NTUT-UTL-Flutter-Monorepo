// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tile.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$BluetoothDeviceTileThemeTailorMixin
    on ThemeExtension<BluetoothDeviceTileTheme> {
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
  BluetoothDeviceTileTheme copyWith({
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
    return BluetoothDeviceTileTheme(
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
  BluetoothDeviceTileTheme lerp(
    covariant ThemeExtension<BluetoothDeviceTileTheme>? other,
    double t,
  ) {
    if (other is! BluetoothDeviceTileTheme)
      return this as BluetoothDeviceTileTheme;
    return BluetoothDeviceTileTheme(
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
            other is BluetoothDeviceTileTheme &&
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

extension BluetoothDeviceTileThemeBuildContextProps on BuildContext {
  BluetoothDeviceTileTheme get bluetoothDeviceTileTheme =>
      Theme.of(this).extension<BluetoothDeviceTileTheme>()!;
  IconData get classicIcon => bluetoothDeviceTileTheme.classicIcon;
  Color get connectedColor => bluetoothDeviceTileTheme.connectedColor;
  IconData get connectedIcon => bluetoothDeviceTileTheme.connectedIcon;
  Color get disconnectedColor => bluetoothDeviceTileTheme.disconnectedColor;
  IconData get disconnectedIcon => bluetoothDeviceTileTheme.disconnectedIcon;
  Color get highlightColor => bluetoothDeviceTileTheme.highlightColor;
  IconData get highSpeedIcon => bluetoothDeviceTileTheme.highSpeedIcon;
  IconData get inSystemIcon => bluetoothDeviceTileTheme.inSystemIcon;
  IconData get lowPowerIcon => bluetoothDeviceTileTheme.lowPowerIcon;
  IconData get nullRssiIcon => bluetoothDeviceTileTheme.nullRssiIcon;
  IconData get pairedIcon => bluetoothDeviceTileTheme.pairedIcon;
  Color get selectedColor => bluetoothDeviceTileTheme.selectedColor;
  Color get typeIconColor => bluetoothDeviceTileTheme.typeIconColor;
  IconData get unpairedIcon => bluetoothDeviceTileTheme.unpairedIcon;
}
