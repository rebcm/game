import 'package:flutter/material.dart';

class InputNormalizer {
  final double deadzone;

  InputNormalizer({required this.deadzone});

  double normalize(double input) {
    if (input.abs() <= deadzone) {
      return 0;
    }

    double normalizedInput = (input.abs() - deadzone) / (1 - deadzone);
    return input.sign * normalizedInput;
  }
}
