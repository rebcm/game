import 'package:flutter/material.dart';
import 'package:rebcm/utils/input_normalizer.dart';

class PlayerController with ChangeNotifier {
  InputNormalizer _inputNormalizer = InputNormalizer(0.1);
  double _inputValue = 0.0;

  void updateInput(double input) {
    _inputValue = _inputNormalizer.normalize(input);
    notifyListeners();
  }

  double get inputValue => _inputValue;
}
