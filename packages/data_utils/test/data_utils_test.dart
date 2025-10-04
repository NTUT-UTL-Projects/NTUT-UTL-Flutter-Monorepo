import 'package:flutter_test/flutter_test.dart';

import 'package:data_utils/data_utils.dart';

void main() {
  test('String converter', () {
    expect([0x00, 0x80, 0xFF].toByteStrings(), ["00", "80", "FF"]);
    expect("0080FF".hexToBytes(), [0x00, 0x80, 0xFF]);
  });
}
