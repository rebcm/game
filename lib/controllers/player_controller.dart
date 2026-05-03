import 'package:flutter/material.dart';
import 'package:rebcm/utils/input_normalizer.dart';

class PlayerController with ChangeNotifier {
  final InputNormalizer _inputNormalizer;
  double _rawInput = 0.0;

  PlayerController({
    required InputNormalizer inputNormalizer,
  }) : _inputNormalizer = inputNormalizer;

  void updateRawInput(double rawInput) {
    _rawInput = rawInput;
    notifyListeners();
  }

  double getNormalizedInput(double deltaTime) {
    return _inputNormalizer.normalizeInput(_rawInput, deltaTime);
  }
}
