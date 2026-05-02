import 'package:flutter/material.dart';

class InputHandler with ChangeNotifier {
  double _velocity = 0;

  double get velocity => _velocity;

  void updateVelocity(double newVelocity) {
    _velocity = newVelocity;
    notifyListeners();
  }

  void resetVelocity() {
    _velocity = 0;
    notifyListeners();
  }
}
