// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_page.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$HomePageThemeTailorMixin on ThemeExtension<HomePageTheme> {
  IconData get bluetoothScannerIcon;
  IconData get seatCushion3DMeshIcon;
  IconData get seatCushionDashboardIcon;

  @override
  HomePageTheme copyWith({
    IconData? bluetoothScannerIcon,
    IconData? seatCushion3DMeshIcon,
    IconData? seatCushionDashboardIcon,
  }) {
    return HomePageTheme(
      bluetoothScannerIcon: bluetoothScannerIcon ?? this.bluetoothScannerIcon,
      seatCushion3DMeshIcon:
          seatCushion3DMeshIcon ?? this.seatCushion3DMeshIcon,
      seatCushionDashboardIcon:
          seatCushionDashboardIcon ?? this.seatCushionDashboardIcon,
    );
  }

  @override
  HomePageTheme lerp(covariant ThemeExtension<HomePageTheme>? other, double t) {
    if (other is! HomePageTheme) return this as HomePageTheme;
    return HomePageTheme(
      bluetoothScannerIcon: t < 0.5
          ? bluetoothScannerIcon
          : other.bluetoothScannerIcon,
      seatCushion3DMeshIcon: t < 0.5
          ? seatCushion3DMeshIcon
          : other.seatCushion3DMeshIcon,
      seatCushionDashboardIcon: t < 0.5
          ? seatCushionDashboardIcon
          : other.seatCushionDashboardIcon,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomePageTheme &&
            const DeepCollectionEquality().equals(
              bluetoothScannerIcon,
              other.bluetoothScannerIcon,
            ) &&
            const DeepCollectionEquality().equals(
              seatCushion3DMeshIcon,
              other.seatCushion3DMeshIcon,
            ) &&
            const DeepCollectionEquality().equals(
              seatCushionDashboardIcon,
              other.seatCushionDashboardIcon,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(bluetoothScannerIcon),
      const DeepCollectionEquality().hash(seatCushion3DMeshIcon),
      const DeepCollectionEquality().hash(seatCushionDashboardIcon),
    );
  }
}

extension HomePageThemeBuildContextProps on BuildContext {
  HomePageTheme get homePageTheme => Theme.of(this).extension<HomePageTheme>()!;
  IconData get bluetoothScannerIcon => homePageTheme.bluetoothScannerIcon;
  IconData get seatCushion3DMeshIcon => homePageTheme.seatCushion3DMeshIcon;
  IconData get seatCushionDashboardIcon =>
      homePageTheme.seatCushionDashboardIcon;
}
