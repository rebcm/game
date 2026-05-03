import 'package:flutter/material.dart';

class InputNormalizer {
  double _previousValue = 0.0;
  double _threshold = 0.1; // Deadzone threshold

  InputNormalizer(this._threshold);

  double normalize(double inputValue) {
    if (inputValue.abs() < _threshold) {
      _previousValue = 0.0;
      return 0.0;
    }

    // Linear interpolation to smoothly transition from 0 to the threshold value
    double targetValue = inputValue > 0 ? 1.0 : -1.0;
    _previousValue = (_previousValue + (targetValue - _previousValue) * 0.1).clamp(-1.0, 1.0);

    return _previousValue;
  }
}
