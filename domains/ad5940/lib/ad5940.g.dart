// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad5940.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$Ad5940CommandCWProxy {
  Ad5940Command main(Ad5940CommandMain main);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Ad5940Command(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Ad5940Command(...).copyWith(id: 12, name: "My name")
  /// ```
  Ad5940Command call({Ad5940CommandMain main});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAd5940Command.copyWith(...)` or call `instanceOfAd5940Command.copyWith.fieldName(value)` for a single field.
class _$Ad5940CommandCWProxyImpl implements _$Ad5940CommandCWProxy {
  const _$Ad5940CommandCWProxyImpl(this._value);

  final Ad5940Command _value;

  @override
  Ad5940Command main(Ad5940CommandMain main) => call(main: main);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Ad5940Command(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Ad5940Command(...).copyWith(id: 12, name: "My name")
  /// ```
  Ad5940Command call({Object? main = const $CopyWithPlaceholder()}) {
    return Ad5940Command(
      main: main == const $CopyWithPlaceholder() || main == null
          ? _value.main
          // ignore: cast_nullable_to_non_nullable
          : main as Ad5940CommandMain,
    );
  }
}

extension $Ad5940CommandCopyWith on Ad5940Command {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAd5940Command.copyWith(...)` or `instanceOfAd5940Command.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$Ad5940CommandCWProxy get copyWith => _$Ad5940CommandCWProxyImpl(this);
}

abstract class _$AD5940ResultCWProxy {
  AD5940Result lptias(List<double> lptias);

  AD5940Result hstias(List<double> hstias);

  AD5940Result temperatures(List<double> temperatures);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AD5940Result(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AD5940Result(...).copyWith(id: 12, name: "My name")
  /// ```
  AD5940Result call({
    List<double> lptias,
    List<double> hstias,
    List<double> temperatures,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAD5940Result.copyWith(...)` or call `instanceOfAD5940Result.copyWith.fieldName(value)` for a single field.
class _$AD5940ResultCWProxyImpl implements _$AD5940ResultCWProxy {
  const _$AD5940ResultCWProxyImpl(this._value);

  final AD5940Result _value;

  @override
  AD5940Result lptias(List<double> lptias) => call(lptias: lptias);

  @override
  AD5940Result hstias(List<double> hstias) => call(hstias: hstias);

  @override
  AD5940Result temperatures(List<double> temperatures) =>
      call(temperatures: temperatures);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AD5940Result(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AD5940Result(...).copyWith(id: 12, name: "My name")
  /// ```
  AD5940Result call({
    Object? lptias = const $CopyWithPlaceholder(),
    Object? hstias = const $CopyWithPlaceholder(),
    Object? temperatures = const $CopyWithPlaceholder(),
  }) {
    return AD5940Result(
      lptias: lptias == const $CopyWithPlaceholder() || lptias == null
          ? _value.lptias
          // ignore: cast_nullable_to_non_nullable
          : lptias as List<double>,
      hstias: hstias == const $CopyWithPlaceholder() || hstias == null
          ? _value.hstias
          // ignore: cast_nullable_to_non_nullable
          : hstias as List<double>,
      temperatures:
          temperatures == const $CopyWithPlaceholder() || temperatures == null
          ? _value.temperatures
          // ignore: cast_nullable_to_non_nullable
          : temperatures as List<double>,
    );
  }
}

extension $AD5940ResultCopyWith on AD5940Result {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAD5940Result.copyWith(...)` or `instanceOfAD5940Result.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AD5940ResultCWProxy get copyWith => _$AD5940ResultCWProxyImpl(this);
}

abstract class _$AD5940TaskCWProxy {
  AD5940Task commands(List<Ad5940Command> commands);

  AD5940Task results(List<AD5940Result> results);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AD5940Task(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AD5940Task(...).copyWith(id: 12, name: "My name")
  /// ```
  AD5940Task call({List<Ad5940Command> commands, List<AD5940Result> results});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAD5940Task.copyWith(...)` or call `instanceOfAD5940Task.copyWith.fieldName(value)` for a single field.
class _$AD5940TaskCWProxyImpl implements _$AD5940TaskCWProxy {
  const _$AD5940TaskCWProxyImpl(this._value);

  final AD5940Task _value;

  @override
  AD5940Task commands(List<Ad5940Command> commands) => call(commands: commands);

  @override
  AD5940Task results(List<AD5940Result> results) => call(results: results);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AD5940Task(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AD5940Task(...).copyWith(id: 12, name: "My name")
  /// ```
  AD5940Task call({
    Object? commands = const $CopyWithPlaceholder(),
    Object? results = const $CopyWithPlaceholder(),
  }) {
    return AD5940Task(
      commands: commands == const $CopyWithPlaceholder() || commands == null
          ? _value.commands
          // ignore: cast_nullable_to_non_nullable
          : commands as List<Ad5940Command>,
      results: results == const $CopyWithPlaceholder() || results == null
          ? _value.results
          // ignore: cast_nullable_to_non_nullable
          : results as List<AD5940Result>,
    );
  }
}

extension $AD5940TaskCopyWith on AD5940Task {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAD5940Task.copyWith(...)` or `instanceOfAD5940Task.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AD5940TaskCWProxy get copyWith => _$AD5940TaskCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ad5940Command _$Ad5940CommandFromJson(Map<String, dynamic> json) =>
    Ad5940Command(main: $enumDecode(_$Ad5940CommandMainEnumMap, json['main']));

Map<String, dynamic> _$Ad5940CommandToJson(Ad5940Command instance) =>
    <String, dynamic>{'main': _$Ad5940CommandMainEnumMap[instance.main]!};

const _$Ad5940CommandMainEnumMap = {
  Ad5940CommandMain.reboot: 'reboot',
  Ad5940CommandMain.stop: 'stop',
  Ad5940CommandMain.start: 'start',
  Ad5940CommandMain.write: 'write',
};

AD5940Result _$AD5940ResultFromJson(Map<String, dynamic> json) => AD5940Result(
  lptias: (json['lptias'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  hstias: (json['hstias'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  temperatures: (json['temperatures'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
);

Map<String, dynamic> _$AD5940ResultToJson(AD5940Result instance) =>
    <String, dynamic>{
      'lptias': instance.lptias,
      'hstias': instance.hstias,
      'temperatures': instance.temperatures,
    };

AD5940Task _$AD5940TaskFromJson(Map<String, dynamic> json) => AD5940Task(
  commands: (json['commands'] as List<dynamic>)
      .map((e) => Ad5940Command.fromJson(e as Map<String, dynamic>))
      .toList(),
  results: (json['results'] as List<dynamic>)
      .map((e) => AD5940Result.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AD5940TaskToJson(AD5940Task instance) =>
    <String, dynamic>{
      'commands': instance.commands,
      'results': instance.results,
    };
