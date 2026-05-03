import 'package:flutter/services.dart';

class KeyboardService {
  static const List<LogicalKeyboardKey> _nativeKeys = [
    LogicalKeyboardKey.ctrl, // Ctrl
    LogicalKeyboardKey.alt, // Alt
    LogicalKeyboardKey.f1, // F1
    LogicalKeyboardKey.f2, // F2
    LogicalKeyboardKey.f3, // F3
    LogicalKeyboardKey.f4, // F4
    LogicalKeyboardKey.f5, // F5
    LogicalKeyboardKey.f6, // F6
    LogicalKeyboardKey.f7, // F7
    LogicalKeyboardKey.f8, // F8
    LogicalKeyboardKey.f9, // F9
    LogicalKeyboardKey.f10, // F10
    LogicalKeyboardKey.f11, // F11
    LogicalKeyboardKey.f12, // F12
  ];

  bool isNativeKey(LogicalKeyboardKey key) {
    return _nativeKeys.contains(key);
  }

  // Método para verificar se uma tecla deve ser interceptada
  bool shouldInterceptKey(LogicalKeyboardKey key) {
    // Lógica para determinar se a tecla deve ser interceptada
    // Exemplo:
    return !isNativeKey(key);
  }
}
