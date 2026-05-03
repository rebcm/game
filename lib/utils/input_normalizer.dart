import 'package:flutter/material.dart';

class InputNormalizer {
  final double _deadzoneThreshold;
  final double _maxSpeed;
  double _previousNormalizedInput;

  InputNormalizer({
    required double deadzoneThreshold,
    required double maxSpeed,
  })  : _deadzoneThreshold = deadzoneThreshold,
        _maxSpeed = maxSpeed,
        _previousNormalizedInput = 0.0;

  double normalizeInput(double rawInput, double deltaTime) {
    if (rawInput.abs() < _deadzoneThreshold) {
      return 0.0;
    }

    double inputAfterDeadzone = rawInput.abs() - _deadzoneThreshold;
    double maxInputAfterDeadzone = 1.0 - _deadzoneThreshold;
    double normalizedInput = inputAfterDeadzone / maxInputAfterDeadzone;

    _previousNormalizedInput = _lerp(
      _previousNormalizedInput,
      normalizedInput * rawInput.sign,
      deltaTime,
    );

    return _previousNormalizedInput * _maxSpeed;
  }

  double _lerp(double start, double end, double deltaTime) {
    const double lerpFactor = 10.0;
    return start + (end - start) * (1 - (-lerpFactor * deltaTime).exp);
  }
}
