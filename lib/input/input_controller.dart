import 'package:flutter/material.dart';

class InputController with ChangeNotifier {
  double _rawInputX = 0.0;
  double _rawInputY = 0.0;
  double _deadzone = 0.2;

  double get normalizedX => _normalizeInput(_rawInputX);
  double get normalizedY => _normalizeInput(_rawInputY);

  double _normalizeInput(double input) {
    if (input.abs() < _deadzone) {
      return 0.0;
    } else {
      return (input - (_deadzone * input.sign)) / (1 - _deadzone);
    }
  }

  void updateInput(double x, double y) {
    _rawInputX = x;
    _rawInputY = y;
    notifyListeners();
  }
}
