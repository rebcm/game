import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';

class AnimationController with ChangeNotifier {_animationController = AnimationController with ChangeNotifier {();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
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
