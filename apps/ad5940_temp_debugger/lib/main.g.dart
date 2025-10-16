// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DataCWProxy {
  Data id(int id);

  Data data(List<double> data);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Data(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Data(...).copyWith(id: 12, name: "My name")
  /// ```
  Data call({int id, List<double> data});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfData.copyWith(...)` or call `instanceOfData.copyWith.fieldName(value)` for a single field.
class _$DataCWProxyImpl implements _$DataCWProxy {
  const _$DataCWProxyImpl(this._value);

  final Data _value;

  @override
  Data id(int id) => call(id: id);

  @override
  Data data(List<double> data) => call(data: data);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Data(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Data(...).copyWith(id: 12, name: "My name")
  /// ```
  Data call({
    Object? id = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
  }) {
    return Data(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<double>,
    );
  }
}

extension $DataCopyWith on Data {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfData.copyWith(...)` or `instanceOfData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DataCWProxy get copyWith => _$DataCWProxyImpl(this);
}
