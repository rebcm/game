import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideProvider with ChangeNotifier {
  double _speed = 0;

  double get speed => _speed;

  void updateSpeed(double speed) {
    _speed = speed;
    notifyListeners();
  }
}
