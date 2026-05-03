import 'package:flutter/material.dart';
import 'package:flutter_gl/flutter_gl.dart';

class JoystickController with ChangeNotifier {
  double _x = 0.0;
  double _y = 0.0;
  double _deadZone = 0.1;
  double _interpolatedX = 0.0;
  double _interpolatedY = 0.0;

  double get x => _interpolatedX;
  double get y => _interpolatedY;

  void update(double newX, double newY) {
    _x = newX;
    _y = newY;
    _interpolate();
    notifyListeners();
  }

  void _interpolate() {
    double magnitude = (_x.abs() + _y.abs()) / 2;
    if (magnitude < _deadZone) {
      _interpolatedX = 0.0;
      _interpolatedY = 0.0;
    } else {
      double normalizedMagnitude = (magnitude - _deadZone) / (1 - _deadZone);
      _interpolatedX = _x * normalizedMagnitude;
      _interpolatedY = _y * normalizedMagnitude;
    }
  }
}
