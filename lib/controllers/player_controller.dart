import 'package:flutter/material.dart';
import 'package:rebcm/input/input_normalizer.dart';

class PlayerController with ChangeNotifier {
  final InputNormalizer _inputNormalizer;
  double _inputX = 0;
  double _inputY = 0;

  PlayerController({required InputNormalizer inputNormalizer})
      : _inputNormalizer = inputNormalizer;

  void updateInput(double x, double y) {
    _inputX = _inputNormalizer.normalize(x);
    _inputY = _inputNormalizer.normalize(y);
    notifyListeners();
  }

  double get inputX => _inputX;
  double get inputY => _inputY;
}
