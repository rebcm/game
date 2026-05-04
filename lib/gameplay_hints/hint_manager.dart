import 'package:flutter/material.dart';

class HintManager with ChangeNotifier {
  List<String> _hints = [];

  List<String> get hints => _hints;

  void showHint(String hint) {
    _hints.add(hint);
    notifyListeners();
  }

  void clearHints() {
    _hints.clear();
    notifyListeners();
  }
}
