import 'package:flutter/material.dart';

mixin TextEditingControllerUtils on TextEditingController {
  void backspace() {
    final value = this.value;
    final sel = value.selection;
    if (sel.start == 0 && sel.end == 0) return;

    final newText = value.text.replaceRange(
      sel.isCollapsed ? sel.start - 1 : sel.start,
      sel.end,
      '',
    );

    final newOffset = sel.isCollapsed ? sel.start - 1 : sel.start;

    this.value = TextEditingValue(
      text: newText.toUpperCase(),
      selection: TextSelection.collapsed(
        offset: newOffset.clamp(0, newText.length),
      ),
    );
  }

  void insert(String hexChar) {
    final value = this.value;
    final sel = value.selection;

    final newText = value.text.replaceRange(sel.start, sel.end, hexChar);

    final newOffset = sel.start + hexChar.length;

    this.value = TextEditingValue(
      text: newText.toUpperCase(),
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}
