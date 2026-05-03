import 'package:flutter/material.dart';
import 'package:rebcm/utils/input_normalizer.dart';

class PlayerController with ChangeNotifier {
  final InputNormalizer _inputNormalizer = InputNormalizer();

  double _inputValue = 0.0;
  double get inputValue => _inputValue;

  void updateInput(double input) {
    _inputValue = _inputNormalizer.normalize(input, 0.2, 1.0);
    notifyListeners();
  }
}
