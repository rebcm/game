import 'package:flutter/material.dart';

class DebugProfiler with ChangeNotifier {
  bool _isEnabled = false;

  bool get isEnabled => _isEnabled;

  void toggle() {
    _isEnabled = !_isEnabled;
    notifyListeners();
  }

  void profileWidgetTree() {
    if (_isEnabled) {
      // Implement profiling logic here
      debugPrint('Profiling widget tree...');
    }
  }
}
