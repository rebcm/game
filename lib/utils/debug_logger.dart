import 'package:flutter/material.dart';

class DebugLogger with ChangeNotifier {
  bool _isEnabled = false;

  bool get isEnabled => _isEnabled;

  void toggle() {
    _isEnabled = !_isEnabled;
    notifyListeners();
  }

  void log(String message) {
    if (_isEnabled) {
      print('DEBUG: $message');
    }
  }
}
