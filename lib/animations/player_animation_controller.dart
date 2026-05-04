import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class PlayerAnimationController with ChangeNotifier {_animationController = AnimationController with ChangeNotifier {();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  final AnimationController _animationController;_animationController = AnimationController _animationController;();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }

  PlayerAnimationController(this._animationController) {_animationController = AnimationController(this._animationController) {();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
    _animationController.forward();
  }

  Animation<double> get idleToWalking => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ),
      );

  void transitionToWalking() {
    _animationController.forward(from: 0);
  }

  void transitionToIdle() {
    _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
