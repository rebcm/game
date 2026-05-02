import 'package:flutter/material.dart';
import 'package:passdriver/features/animation_speed_control/models/speed_matrix.dart';

class SpeedMatrixProvider with ChangeNotifier {
  List<SpeedMatrix> _speedMatrix = [];

  List<SpeedMatrix> get speedMatrix => _speedMatrix;

  void loadSpeedMatrix() {
    _speedMatrix = [
      SpeedMatrix(speed: 0, animationSpeed: 0),
      SpeedMatrix(speed: 5, animationSpeed: 1),
      SpeedMatrix(speed: 10, animationSpeed: 2),
      SpeedMatrix(speed: 15, animationSpeed: 3),
      SpeedMatrix(speed: 20, animationSpeed: 4),
    ];
    notifyListeners();
  }
}
