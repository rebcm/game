import 'package:flutter/material.dart';
import 'package:rebcm/input/input_normalizer.dart';

class PlayerController with ChangeNotifier {
  final InputNormalizer _normalizer;

  double _inputX = 0;
  double _inputY = 0;

  PlayerController({required InputNormalizer normalizer}) : _normalizer = normalizer;

  void updateInput(double x, double y) {
    _inputX = _normalizer.normalize(x);
    _inputY = _normalizer.normalize(y);
    notifyListeners();
  }

  double get inputX => _inputX;
  double get inputY => _inputY;
}
