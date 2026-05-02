import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharacterAnimationProvider with ChangeNotifier {
  double _tolerance = 0.05;

  double get tolerance => _tolerance;

  void setTolerance(double tolerance) {
    _tolerance = tolerance;
    notifyListeners();
  }
}
