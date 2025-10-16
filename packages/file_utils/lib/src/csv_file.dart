part of '../file_utils.dart';

extension CsvFile on File {
  Future<File> writeBom({
    bool flush = false,
    FileMode mode = FileMode.write,
  }) {
    return writeAsBytes(
      const [0xef, 0xbb, 0xbf],
      mode: mode,
      flush: flush,
    );
  }

  Future<File> writeAsCsvRow<T>({
    required Iterable<T> data,
    String delimiterColumn = ",",
    String delimiterRow = "\n",
    Encoding encoding = utf8,
    bool flush = false,
    FileMode mode = FileMode.append,
  }) {
    final contents = data.isEmpty
        ? delimiterRow
        : data.join(delimiterColumn) + delimiterRow;
    return writeAsString(
      contents,
      mode: mode,
      encoding: encoding,
      flush: flush,
    );
  }

  Future<Iterable<Iterable<String>>> readAsCsv({
    String delimiterColumn = ",",
    String delimiterRow = "\n",
    Encoding encoding = utf8,
    bool flush = false,
  }) async {
    return (await readAsString(encoding: encoding))
      .split(delimiterRow)
      .map((e) => e.split(delimiterColumn));
  }
}
