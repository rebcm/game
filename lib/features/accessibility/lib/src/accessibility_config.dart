import 'package:flutter/material.dart';
class AccessibilityConfig with ChangeNotifier {
  /// Configurações de remapeamento de teclas
  Map<String, String> _keyBindings = {};
  Map<String, String> get keyBindings => _keyBindings;
  set keyBindings(Map<String, String> value) {
    _keyBindings = value;
    notifyListeners();
  }
}
