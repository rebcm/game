import 'package:flutter/material.dart';

class KeyboardHandler {
  static const List<LogicalKeyboardKey> _ignoredKeys = [
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.meta,
    LogicalKeyboardKey.alt,
    LogicalKeyboardKey.shift,
    LogicalKeyboardKey.f1,
    LogicalKeyboardKey.f2,
    LogicalKeyboardKey.f3,
    LogicalKeyboardKey.f4,
    LogicalKeyboardKey.f5,
    LogicalKeyboardKey.f6,
    LogicalKeyboardKey.f7,
    LogicalKeyboardKey.f8,
    LogicalKeyboardKey.f9,
    LogicalKeyboardKey.f10,
    LogicalKeyboardKey.f11,
    LogicalKeyboardKey.f12,
  ];

  static const List<ShortcutActivator> _ignoredShortcuts = [
    SingleActivator(LogicalKeyboardKey.keyN, control: true),
    SingleActivator(LogicalKeyboardKey.keyT, control: true),
    SingleActivator(LogicalKeyboardKey.keyT, control: true, shift: true),
    SingleActivator(LogicalKeyboardKey.keyW, control: true),
    SingleActivator(LogicalKeyboardKey.f4, control: true),
    SingleActivator(LogicalKeyboardKey.keyR, control: true),
    SingleActivator(LogicalKeyboardKey.keyS, control: true),
    SingleActivator(LogicalKeyboardKey.keyP, control: true),
    SingleActivator(LogicalKeyboardKey.keyI, control: true, shift: true),
    SingleActivator(LogicalKeyboardKey.f12),
    SingleActivator(LogicalKeyboardKey.keyU, control: true),
  ];

  bool shouldIgnoreKey(RawKeyEvent event) {
    if (_ignoredKeys.contains(event.logicalKey)) {
      return true;
    }

    for (var activator in _ignoredShortcuts) {
      if (activator.accepts(event, RawKeyboard.instance)) {
        return true;
      }
    }

    return false;
  }
}
