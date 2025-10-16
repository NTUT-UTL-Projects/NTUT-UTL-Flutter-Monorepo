import 'dart:async';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'hex_keyboard.tailor.dart';

@immutable
@TailorMixin()
class HexKeyboardTheme extends ThemeExtension<HexKeyboardTheme>
    with _$HexKeyboardThemeTailorMixin {
  @override
  final Color backspaceColor;
  @override
  final Color clearColor;
  @override
  final Color submitColor;

  const HexKeyboardTheme({
    required this.backspaceColor,
    required this.clearColor,
    required this.submitColor,
  });
}

/// **Theme**
/// - [HexKeyboardTheme]
class HexKeyboard extends StatelessWidget {
  final TextEditingController controller;

  final FocusNode focusNode;
  final VoidCallback? onSubmitted;

  const HexKeyboard({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSubmitted,
  });

  static const _repeatDelay = Duration(milliseconds: 500);
  static const _repeatRate = Duration(milliseconds: 50);

  void _backspace() {
    if (!focusNode.hasFocus) return;

    final value = controller.value;
    final sel = value.selection;
    if (sel.start == 0 && sel.end == 0) return;

    final newText = value.text.replaceRange(
      sel.isCollapsed ? sel.start - 1 : sel.start,
      sel.end,
      '',
    );

    final newOffset = sel.isCollapsed ? sel.start - 1 : sel.start;

    controller.value = TextEditingValue(
      text: newText.toUpperCase(),
      selection: TextSelection.collapsed(
        offset: newOffset.clamp(0, newText.length),
      ),
    );
  }

  void _insert(String hexChar) {
    if (!focusNode.hasFocus) return;

    final value = controller.value;
    final sel = value.selection;

    final newText = value.text.replaceRange(sel.start, sel.end, hexChar);

    final newOffset = sel.start + hexChar.length;

    controller.value = TextEditingValue(
      text: newText.toUpperCase(),
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final themeExtension = themeData.extension<HexKeyboardTheme>();

    final List<List<Widget>> rows = [
      _buildRow(
        ['0', '1', '2', '3'],
        icon: Icon(Icons.backspace, color: themeExtension?.backspaceColor),
        repeat: true,
        onIconPressed: _backspace,
      ),
      _buildRow(
        ['4', '5', '6', '7'],
        icon: Icon(Icons.delete, color: themeExtension?.clearColor),
        onIconPressed: controller.clear,
      ),
      _buildRow(
        ['8', '9', 'A', 'B'],
        spacer: true,
      ),
      _buildRow(
        ['C', 'D', 'E', 'F'],
        icon: Icon(Icons.send, color: themeExtension?.submitColor),
        onIconPressed: onSubmitted,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      color: themeData.scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: rows
            .map(
              (children) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children
                      .map(
                        (child) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: child,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  List<Widget> _buildRow(
    List<String> keys, {
    Icon? icon,
    VoidCallback? onIconPressed,
    bool spacer = false,
    bool repeat = false,
  }) {
    final buttons = keys
        .map<Widget>(
          (k) => ElevatedButton(onPressed: () => _insert(k), child: Text(k)),
        )
        .toList();

    if (icon != null && onIconPressed != null) {
      buttons.add(_buildIconKey(icon, onIconPressed, repeat));
    } else if (spacer) {
      buttons.add(const SizedBox.shrink());
    }

    return buttons;
  }

  Widget _buildIconKey(Icon icon, VoidCallback onPressed, bool repeat) {
    if (!repeat) {
      return ElevatedButton(onPressed: onPressed, child: icon);
    }

    return _RepeatableButton(icon: icon, onRepeatPressed: onPressed);
  }
}

class _RepeatableButton extends StatefulWidget {
  final Icon icon;
  final VoidCallback onRepeatPressed;

  const _RepeatableButton({required this.icon, required this.onRepeatPressed});

  @override
  State<_RepeatableButton> createState() => _RepeatableButtonState();
}

class _RepeatableButtonState extends State<_RepeatableButton> {
  Timer? _timer;

  void _startRepeat() {
    widget.onRepeatPressed();
    _timer = Timer(HexKeyboard._repeatDelay, () {
      _timer = Timer.periodic(
        HexKeyboard._repeatRate,
        (_) => widget.onRepeatPressed(),
      );
    });
  }

  void _stopRepeat() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) => _startRepeat(),
      onPanEnd: (_) => _stopRepeat(),
      onPanCancel: () => _stopRepeat(),
      child: ElevatedButton(
        onPressed: () {}, // Disabled to force GestureDetector to control
        child: widget.icon,
      ),
    );
  }

  @mustCallSuper
  @override
  void dispose() {
    _stopRepeat();
    super.dispose();
  }
}
