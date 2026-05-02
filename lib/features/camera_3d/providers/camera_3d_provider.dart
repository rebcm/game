import 'package:flutter/material.dart';

class Camera3DProvider with ChangeNotifier {
  double _rotation = 0;

  double get rotation => _rotation;

  void updateRotation(double rotation) {
    _rotation = rotation;
    notifyListeners();
  }
}
