import 'dart:convert';
import 'dart:io';

import 'package:file_utils/file_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider_utils/path_provider_utils.dart';
import 'package:seat_cushion/seat_cushion.dart';

extension SeatCushionFile on File {
  static Future<File> createSeatCushionFile() async {
    final time = DateTime.now();
    final folder = (await getSystemDownloadDirectory())!;
    final appName = (await PackageInfo.fromPlatform()).appName;
    final file = File(
      "${folder.absolute.path}/${appName}_${time.toFileFormat()}.json",
    );
    return file;
  }

  Future<bool> writeHead() async {
    await writeAsString("[", mode: FileMode.append);
    return true;
  }

  Future<bool> writeSeatCushionEntity(SeatCushionEntity entity) async {
    await writeAsString(
      "${jsonEncode(entity.toJson())},",
      mode: FileMode.append,
    );
    return true;
  }

  Future<bool> writeTail() async {
    await writeAsString("]", mode: FileMode.append);
    return true;
  }
}
