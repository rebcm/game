import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/animation.dart';

class MovementAnimationController with ChangeNotifier {_animationController = AnimationController with ChangeNotifier {();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  double _speed = 0.0;
  late AnimationController _animationController;_animationController = AnimationController _animationController;();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }

  MovementAnimationController(_animationController = AnimationController(();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
    vsync: this,this._animationController);
    _movement_animation_controllerAnimationController.dispose();_animationController = AnimationController.dispose();();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }

  void updateSpeed(double speed) {
    _speed = speed;
    _animationController.duration = Duration(milliseconds: (1000 ~/ _speed).clamp(1, 1000));
    notifyListeners();
  }

  void animate() {
    _animationController.forward(from: 0);
  }
}
