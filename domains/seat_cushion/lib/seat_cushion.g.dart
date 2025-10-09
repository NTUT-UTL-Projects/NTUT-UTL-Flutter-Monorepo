// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_cushion.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SeatCushionSetCWProxy {
  SeatCushionSet left(LeftSeatCushion left);

  SeatCushionSet right(RightSeatCushion right);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SeatCushionSet(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SeatCushionSet(...).copyWith(id: 12, name: "My name")
  /// ```
  SeatCushionSet call({LeftSeatCushion left, RightSeatCushion right});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSeatCushionSet.copyWith(...)` or call `instanceOfSeatCushionSet.copyWith.fieldName(value)` for a single field.
class _$SeatCushionSetCWProxyImpl implements _$SeatCushionSetCWProxy {
  const _$SeatCushionSetCWProxyImpl(this._value);

  final SeatCushionSet _value;

  @override
  SeatCushionSet left(LeftSeatCushion left) => call(left: left);

  @override
  SeatCushionSet right(RightSeatCushion right) => call(right: right);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SeatCushionSet(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SeatCushionSet(...).copyWith(id: 12, name: "My name")
  /// ```
  SeatCushionSet call({
    Object? left = const $CopyWithPlaceholder(),
    Object? right = const $CopyWithPlaceholder(),
  }) {
    return SeatCushionSet(
      left: left == const $CopyWithPlaceholder() || left == null
          ? _value.left
          // ignore: cast_nullable_to_non_nullable
          : left as LeftSeatCushion,
      right: right == const $CopyWithPlaceholder() || right == null
          ? _value.right
          // ignore: cast_nullable_to_non_nullable
          : right as RightSeatCushion,
    );
  }
}

extension $SeatCushionSetCopyWith on SeatCushionSet {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSeatCushionSet.copyWith(...)` or `instanceOfSeatCushionSet.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SeatCushionSetCWProxy get copyWith => _$SeatCushionSetCWProxyImpl(this);
}

abstract class _$SeatCushionCWProxy {
  SeatCushion forces(List<List<double>> forces);

  SeatCushion time(DateTime time);

  SeatCushion type(SeatCushionType type);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SeatCushion(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SeatCushion(...).copyWith(id: 12, name: "My name")
  /// ```
  SeatCushion call({
    List<List<double>> forces,
    DateTime time,
    SeatCushionType type,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSeatCushion.copyWith(...)` or call `instanceOfSeatCushion.copyWith.fieldName(value)` for a single field.
class _$SeatCushionCWProxyImpl implements _$SeatCushionCWProxy {
  const _$SeatCushionCWProxyImpl(this._value);

  final SeatCushion _value;

  @override
  SeatCushion forces(List<List<double>> forces) => call(forces: forces);

  @override
  SeatCushion time(DateTime time) => call(time: time);

  @override
  SeatCushion type(SeatCushionType type) => call(type: type);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SeatCushion(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SeatCushion(...).copyWith(id: 12, name: "My name")
  /// ```
  SeatCushion call({
    Object? forces = const $CopyWithPlaceholder(),
    Object? time = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
  }) {
    return SeatCushion(
      forces: forces == const $CopyWithPlaceholder() || forces == null
          ? _value.forces
          // ignore: cast_nullable_to_non_nullable
          : forces as List<List<double>>,
      time: time == const $CopyWithPlaceholder() || time == null
          ? _value.time
          // ignore: cast_nullable_to_non_nullable
          : time as DateTime,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as SeatCushionType,
    );
  }
}

extension $SeatCushionCopyWith on SeatCushion {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSeatCushion.copyWith(...)` or `instanceOfSeatCushion.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SeatCushionCWProxy get copyWith => _$SeatCushionCWProxyImpl(this);
}

abstract class _$LeftSeatCushionCWProxy {
  LeftSeatCushion forces(List<List<double>> forces);

  LeftSeatCushion time(DateTime time);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LeftSeatCushion(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LeftSeatCushion(...).copyWith(id: 12, name: "My name")
  /// ```
  LeftSeatCushion call({List<List<double>> forces, DateTime time});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfLeftSeatCushion.copyWith(...)` or call `instanceOfLeftSeatCushion.copyWith.fieldName(value)` for a single field.
class _$LeftSeatCushionCWProxyImpl implements _$LeftSeatCushionCWProxy {
  const _$LeftSeatCushionCWProxyImpl(this._value);

  final LeftSeatCushion _value;

  @override
  LeftSeatCushion forces(List<List<double>> forces) => call(forces: forces);

  @override
  LeftSeatCushion time(DateTime time) => call(time: time);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LeftSeatCushion(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LeftSeatCushion(...).copyWith(id: 12, name: "My name")
  /// ```
  LeftSeatCushion call({
    Object? forces = const $CopyWithPlaceholder(),
    Object? time = const $CopyWithPlaceholder(),
  }) {
    return LeftSeatCushion(
      forces: forces == const $CopyWithPlaceholder() || forces == null
          ? _value.forces
          // ignore: cast_nullable_to_non_nullable
          : forces as List<List<double>>,
      time: time == const $CopyWithPlaceholder() || time == null
          ? _value.time
          // ignore: cast_nullable_to_non_nullable
          : time as DateTime,
    );
  }
}

extension $LeftSeatCushionCopyWith on LeftSeatCushion {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfLeftSeatCushion.copyWith(...)` or `instanceOfLeftSeatCushion.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeftSeatCushionCWProxy get copyWith => _$LeftSeatCushionCWProxyImpl(this);
}

abstract class _$RightSeatCushionCWProxy {
  RightSeatCushion forces(List<List<double>> forces);

  RightSeatCushion time(DateTime time);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RightSeatCushion(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RightSeatCushion(...).copyWith(id: 12, name: "My name")
  /// ```
  RightSeatCushion call({List<List<double>> forces, DateTime time});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRightSeatCushion.copyWith(...)` or call `instanceOfRightSeatCushion.copyWith.fieldName(value)` for a single field.
class _$RightSeatCushionCWProxyImpl implements _$RightSeatCushionCWProxy {
  const _$RightSeatCushionCWProxyImpl(this._value);

  final RightSeatCushion _value;

  @override
  RightSeatCushion forces(List<List<double>> forces) => call(forces: forces);

  @override
  RightSeatCushion time(DateTime time) => call(time: time);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RightSeatCushion(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RightSeatCushion(...).copyWith(id: 12, name: "My name")
  /// ```
  RightSeatCushion call({
    Object? forces = const $CopyWithPlaceholder(),
    Object? time = const $CopyWithPlaceholder(),
  }) {
    return RightSeatCushion(
      forces: forces == const $CopyWithPlaceholder() || forces == null
          ? _value.forces
          // ignore: cast_nullable_to_non_nullable
          : forces as List<List<double>>,
      time: time == const $CopyWithPlaceholder() || time == null
          ? _value.time
          // ignore: cast_nullable_to_non_nullable
          : time as DateTime,
    );
  }
}

extension $RightSeatCushionCopyWith on RightSeatCushion {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRightSeatCushion.copyWith(...)` or `instanceOfRightSeatCushion.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RightSeatCushionCWProxy get copyWith => _$RightSeatCushionCWProxyImpl(this);
}

abstract class _$SeatCushionEntityCWProxy {
  SeatCushionEntity id(int id);

  SeatCushionEntity seatCushion(SeatCushion seatCushion);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SeatCushionEntity(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SeatCushionEntity(...).copyWith(id: 12, name: "My name")
  /// ```
  SeatCushionEntity call({int id, SeatCushion seatCushion});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSeatCushionEntity.copyWith(...)` or call `instanceOfSeatCushionEntity.copyWith.fieldName(value)` for a single field.
class _$SeatCushionEntityCWProxyImpl implements _$SeatCushionEntityCWProxy {
  const _$SeatCushionEntityCWProxyImpl(this._value);

  final SeatCushionEntity _value;

  @override
  SeatCushionEntity id(int id) => call(id: id);

  @override
  SeatCushionEntity seatCushion(SeatCushion seatCushion) =>
      call(seatCushion: seatCushion);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SeatCushionEntity(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SeatCushionEntity(...).copyWith(id: 12, name: "My name")
  /// ```
  SeatCushionEntity call({
    Object? id = const $CopyWithPlaceholder(),
    Object? seatCushion = const $CopyWithPlaceholder(),
  }) {
    return SeatCushionEntity(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      seatCushion:
          seatCushion == const $CopyWithPlaceholder() || seatCushion == null
          ? _value.seatCushion
          // ignore: cast_nullable_to_non_nullable
          : seatCushion as SeatCushion,
    );
  }
}

extension $SeatCushionEntityCopyWith on SeatCushionEntity {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSeatCushionEntity.copyWith(...)` or `instanceOfSeatCushionEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SeatCushionEntityCWProxy get copyWith =>
      _$SeatCushionEntityCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatCushionSet _$SeatCushionSetFromJson(Map<String, dynamic> json) =>
    SeatCushionSet(
      left: LeftSeatCushion.fromJson(json['left'] as Map<String, dynamic>),
      right: RightSeatCushion.fromJson(json['right'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeatCushionSetToJson(SeatCushionSet instance) =>
    <String, dynamic>{
      'left': LeftSeatCushion._toJson(instance.left),
      'right': RightSeatCushion._toJson(instance.right),
    };

SeatCushion _$SeatCushionFromJson(Map<String, dynamic> json) => SeatCushion(
  forces: (json['forces'] as List<dynamic>)
      .map(
        (e) => (e as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
      )
      .toList(),
  time: DateTime.parse(json['time'] as String),
  type: $enumDecode(_$SeatCushionTypeEnumMap, json['type']),
);

Map<String, dynamic> _$SeatCushionToJson(SeatCushion instance) =>
    <String, dynamic>{
      'forces': instance.forces,
      'time': instance.time.toIso8601String(),
      'type': _$SeatCushionTypeEnumMap[instance.type]!,
    };

const _$SeatCushionTypeEnumMap = {
  SeatCushionType.left: 'left',
  SeatCushionType.right: 'right',
};

LeftSeatCushion _$LeftSeatCushionFromJson(Map<String, dynamic> json) =>
    LeftSeatCushion(
      forces: (json['forces'] as List<dynamic>)
          .map(
            (e) =>
                (e as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
          )
          .toList(),
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$LeftSeatCushionToJson(LeftSeatCushion instance) =>
    <String, dynamic>{
      'forces': instance.forces,
      'time': instance.time.toIso8601String(),
    };

RightSeatCushion _$RightSeatCushionFromJson(Map<String, dynamic> json) =>
    RightSeatCushion(
      forces: (json['forces'] as List<dynamic>)
          .map(
            (e) =>
                (e as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
          )
          .toList(),
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$RightSeatCushionToJson(RightSeatCushion instance) =>
    <String, dynamic>{
      'forces': instance.forces,
      'time': instance.time.toIso8601String(),
    };

SeatCushionEntity _$SeatCushionEntityFromJson(Map<String, dynamic> json) =>
    SeatCushionEntity(
      id: (json['id'] as num).toInt(),
      seatCushion: SeatCushion.fromJson(
        json['seatCushion'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$SeatCushionEntityToJson(SeatCushionEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seatCushion': SeatCushion._toJson(instance.seatCushion),
    };
