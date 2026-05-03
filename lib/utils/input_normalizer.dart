import 'package:flutter/material.dart';

class InputNormalizer {
  double _previousValue = 0.0;
  double _currentValue = 0.0;

  double normalize(double inputValue, double deadzone, double threshold) {
    if (inputValue.abs() < deadzone) {
      _currentValue = 0.0;
    } else {
      _currentValue = (inputValue.abs() - deadzone) / (1 - deadzone) * threshold * inputValue.sign;
    }

    _currentValue = (_currentValue + _previousValue * 3) / 4;
    _previousValue = _currentValue;

    return _currentValue;
  }
}
