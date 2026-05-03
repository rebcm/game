import 'package:flutter/material.dart';

class InputNormalizer {
  final double deadzone;

  InputNormalizer({required this.deadzone});

  double normalize(double input) {
    if (input.abs() < deadzone) {
      return 0;
    } else {
      return (input - deadzone * input.sign) / (1 - deadzone);
    }
  }
}
