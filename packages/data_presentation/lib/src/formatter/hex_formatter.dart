import 'package:flutter/services.dart';

class HexFormatter extends TextInputFormatter {
  final RegExp _hexRegex = RegExp(r'[0-9a-fA-F\r\n]');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final filtered = newValue.text
        .split('')
        .where((char) => _hexRegex.hasMatch(char))
        .join()
        .toUpperCase();

    return TextEditingValue(
      text: filtered,
      selection: TextSelection.collapsed(offset: filtered.length),
    );
  }
}
