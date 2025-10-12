// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_page.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$HomePageThemeTailorMixin on ThemeExtension<HomePageTheme> {
  Color get appBarBackgroundColor;
  IconData Function(BluetoothDevicesFilter) get filterToIcon;
  Color get highlightColor;
  Color get startTaskColor;
  Color get stopTaskColor;
  Color get timestampColor;
  Color get toggleFilterColor;

  @override
  HomePageTheme copyWith({
    Color? appBarBackgroundColor,
    IconData Function(BluetoothDevicesFilter)? filterToIcon,
    Color? highlightColor,
    Color? startTaskColor,
    Color? stopTaskColor,
    Color? timestampColor,
    Color? toggleFilterColor,
  }) {
    return HomePageTheme(
      appBarBackgroundColor:
          appBarBackgroundColor ?? this.appBarBackgroundColor,
      filterToIcon: filterToIcon ?? this.filterToIcon,
      highlightColor: highlightColor ?? this.highlightColor,
      startTaskColor: startTaskColor ?? this.startTaskColor,
      stopTaskColor: stopTaskColor ?? this.stopTaskColor,
      timestampColor: timestampColor ?? this.timestampColor,
      toggleFilterColor: toggleFilterColor ?? this.toggleFilterColor,
    );
  }

  @override
  HomePageTheme lerp(covariant ThemeExtension<HomePageTheme>? other, double t) {
    if (other is! HomePageTheme) return this as HomePageTheme;
    return HomePageTheme(
      appBarBackgroundColor: Color.lerp(
        appBarBackgroundColor,
        other.appBarBackgroundColor,
        t,
      )!,
      filterToIcon: t < 0.5 ? filterToIcon : other.filterToIcon,
      highlightColor: Color.lerp(highlightColor, other.highlightColor, t)!,
      startTaskColor: Color.lerp(startTaskColor, other.startTaskColor, t)!,
      stopTaskColor: Color.lerp(stopTaskColor, other.stopTaskColor, t)!,
      timestampColor: Color.lerp(timestampColor, other.timestampColor, t)!,
      toggleFilterColor: Color.lerp(
        toggleFilterColor,
        other.toggleFilterColor,
        t,
      )!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomePageTheme &&
            const DeepCollectionEquality().equals(
              appBarBackgroundColor,
              other.appBarBackgroundColor,
            ) &&
            const DeepCollectionEquality().equals(
              filterToIcon,
              other.filterToIcon,
            ) &&
            const DeepCollectionEquality().equals(
              highlightColor,
              other.highlightColor,
            ) &&
            const DeepCollectionEquality().equals(
              startTaskColor,
              other.startTaskColor,
            ) &&
            const DeepCollectionEquality().equals(
              stopTaskColor,
              other.stopTaskColor,
            ) &&
            const DeepCollectionEquality().equals(
              timestampColor,
              other.timestampColor,
            ) &&
            const DeepCollectionEquality().equals(
              toggleFilterColor,
              other.toggleFilterColor,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(appBarBackgroundColor),
      const DeepCollectionEquality().hash(filterToIcon),
      const DeepCollectionEquality().hash(highlightColor),
      const DeepCollectionEquality().hash(startTaskColor),
      const DeepCollectionEquality().hash(stopTaskColor),
      const DeepCollectionEquality().hash(timestampColor),
      const DeepCollectionEquality().hash(toggleFilterColor),
    );
  }
}

extension HomePageThemeBuildContextProps on BuildContext {
  HomePageTheme get homePageTheme => Theme.of(this).extension<HomePageTheme>()!;
  Color get appBarBackgroundColor => homePageTheme.appBarBackgroundColor;
  IconData Function(BluetoothDevicesFilter) get filterToIcon =>
      homePageTheme.filterToIcon;
  Color get highlightColor => homePageTheme.highlightColor;
  Color get startTaskColor => homePageTheme.startTaskColor;
  Color get stopTaskColor => homePageTheme.stopTaskColor;
  Color get timestampColor => homePageTheme.timestampColor;
  Color get toggleFilterColor => homePageTheme.toggleFilterColor;
}
