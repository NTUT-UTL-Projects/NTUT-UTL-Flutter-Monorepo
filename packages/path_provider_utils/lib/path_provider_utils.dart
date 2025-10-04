import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<Directory?> getSystemDownloadDirectory() async {
  try {
    if (Platform.isIOS) {
      return getApplicationDocumentsDirectory();
    } else {
      Directory download = Directory('/storage/emulated/0/Download');
      // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
      // ignore: avoid_slow_async_io
      if (await download.exists()) {
        return download;
      } else {
        return getExternalStorageDirectory();
      }
    }
  } catch (err) {}
  return null;
}
