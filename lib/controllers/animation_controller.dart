import 'package:flutter/material.dart';

class AnimationController with ChangeNotifier {
  bool _isAnimating = false;

  bool get isAnimating => _isAnimating;

  void startAnimation() {
    _isAnimating = true;
    notifyListeners();
  }

  void stopAnimation() {
    _isAnimating = false;
    notifyListeners();
  }
}
