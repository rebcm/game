import 'package:flutter/material.dart';

class PlayerMovement with ChangeNotifier {
  Vector2 _velocity = Vector2.zero();

  Vector2 get velocity => _velocity;

  void updateDirection(double x, double y) {
    _velocity = Vector2(x, y);
    if (_velocity.x.abs() > 1 || _velocity.y.abs() > 1) {
      _velocity.normalize();
    }
    notifyListeners();
  }
}
