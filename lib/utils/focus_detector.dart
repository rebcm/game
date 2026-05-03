import 'package:flutter/material.dart';

class FocusDetector with ChangeNotifier {
  bool _hasFocus = false;

  bool get hasFocus => _hasFocus;

  void onFocusChange(bool hasFocus) {
    _hasFocus = hasFocus;
    notifyListeners();
  }
}
