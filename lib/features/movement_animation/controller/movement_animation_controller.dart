import 'package:flutter/animation.dart';

class MovementAnimationController with ChangeNotifier {
  double _speed = 0.0;
  late AnimationController _animationController;

  MovementAnimationController(this._animationController);

  void updateSpeed(double speed) {
    _speed = speed;
    _animationController.duration = Duration(milliseconds: (1000 ~/ _speed).clamp(1, 1000));
    notifyListeners();
  }

  void animate() {
    _animationController.forward(from: 0);
  }
}
