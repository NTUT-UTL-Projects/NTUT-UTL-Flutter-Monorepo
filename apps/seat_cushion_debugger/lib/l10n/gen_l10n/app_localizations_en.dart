// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String downloadFileButtonText(String format) {
    return 'Download $format file';
  }

  @override
  String downloadFileFinishedNotification(Object format) {
    return 'Download $format file finished.';
  }

  @override
  String get force => 'Force';

  @override
  String get centerOfForces => 'Center Of Forces';

  @override
  String get ischiumPosition => 'Ischium Position';

  @override
  String get ischiumWidth => 'Ischium Width';
}
