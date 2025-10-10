// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String downloadFileButtonText(String format) {
    return '下载 $format 文件';
  }

  @override
  String downloadFileFinishedNotification(Object format) {
    return '下载 $format 完成。';
  }

  @override
  String get force => '力量';

  @override
  String get centerOfForces => '力量中心';

  @override
  String get ischiumPosition => '坐骨位置';

  @override
  String get ischiumWidth => '坐骨宽度';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String downloadFileButtonText(String format) {
    return '下載 $format 文件';
  }

  @override
  String downloadFileFinishedNotification(Object format) {
    return '下載 $format 完成。';
  }

  @override
  String get force => '力量';

  @override
  String get centerOfForces => '力量中心';

  @override
  String get ischiumPosition => '坐骨位置';

  @override
  String get ischiumWidth => '坐骨寬度';
}
