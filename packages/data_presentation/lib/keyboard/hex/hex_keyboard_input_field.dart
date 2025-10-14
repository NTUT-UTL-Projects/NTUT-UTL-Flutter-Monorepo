import 'package:flutter/material.dart';

import '../../formatter/hex_formatter.dart';

class HexKeyboardInputField extends StatelessWidget {
  @protected
  final TextEditingController controller;

  @protected
  final FocusNode focusNode;

  const HexKeyboardInputField({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      readOnly: false,
      obscureText: false,
      enableInteractiveSelection: true,
      keyboardType: TextInputType.none,
      showCursor: true,
      inputFormatters: [
        HexFormatter(),
      ],
      contextMenuBuilder: (context, editableTextState) {
        return AdaptiveTextSelectionToolbar.buttonItems(
          anchors: editableTextState.contextMenuAnchors,
          buttonItems: [
            ...editableTextState.contextMenuButtonItems, // Native items.
          ],
        );
      },
      decoration: const InputDecoration(
        hintText: 'Hex Input',
      ),
      style: const TextStyle(fontSize: 14),
    );
  }
}
