import 'package:flutter/material.dart';

class GravityProvider with ChangeNotifier {
  Vector3 _globalGravity = globalGravity;

  Vector3 get globalGravity => _globalGravity;

  void updateGlobalGravity(Vector3 newGravity) {
    _globalGravity = newGravity;
    notifyListeners();
  }
}
