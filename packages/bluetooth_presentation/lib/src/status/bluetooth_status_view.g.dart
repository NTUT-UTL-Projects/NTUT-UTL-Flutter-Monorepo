// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bluetooth_status_view.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BluetoothStatusControllerCWProxy {
  BluetoothStatusController buttonText(String buttonText);

  BluetoothStatusController iconData(IconData iconData);

  BluetoothStatusController message(String message);

  BluetoothStatusController onPressedButton(VoidCallback? onPressedButton);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BluetoothStatusController(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BluetoothStatusController(...).copyWith(id: 12, name: "My name")
  /// ```
  BluetoothStatusController call({
    String buttonText,
    IconData iconData,
    String message,
    VoidCallback? onPressedButton,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBluetoothStatusController.copyWith(...)` or call `instanceOfBluetoothStatusController.copyWith.fieldName(value)` for a single field.
class _$BluetoothStatusControllerCWProxyImpl
    implements _$BluetoothStatusControllerCWProxy {
  const _$BluetoothStatusControllerCWProxyImpl(this._value);

  final BluetoothStatusController _value;

  @override
  BluetoothStatusController buttonText(String buttonText) =>
      call(buttonText: buttonText);

  @override
  BluetoothStatusController iconData(IconData iconData) =>
      call(iconData: iconData);

  @override
  BluetoothStatusController message(String message) => call(message: message);

  @override
  BluetoothStatusController onPressedButton(VoidCallback? onPressedButton) =>
      call(onPressedButton: onPressedButton);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BluetoothStatusController(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BluetoothStatusController(...).copyWith(id: 12, name: "My name")
  /// ```
  BluetoothStatusController call({
    Object? buttonText = const $CopyWithPlaceholder(),
    Object? iconData = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? onPressedButton = const $CopyWithPlaceholder(),
  }) {
    return BluetoothStatusController(
      buttonText:
          buttonText == const $CopyWithPlaceholder() || buttonText == null
          ? _value.buttonText
          // ignore: cast_nullable_to_non_nullable
          : buttonText as String,
      iconData: iconData == const $CopyWithPlaceholder() || iconData == null
          ? _value.iconData
          // ignore: cast_nullable_to_non_nullable
          : iconData as IconData,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      onPressedButton: onPressedButton == const $CopyWithPlaceholder()
          ? _value.onPressedButton
          // ignore: cast_nullable_to_non_nullable
          : onPressedButton as VoidCallback?,
    );
  }
}

extension $BluetoothStatusControllerCopyWith on BluetoothStatusController {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBluetoothStatusController.copyWith(...)` or `instanceOfBluetoothStatusController.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BluetoothStatusControllerCWProxy get copyWith =>
      _$BluetoothStatusControllerCWProxyImpl(this);
}
