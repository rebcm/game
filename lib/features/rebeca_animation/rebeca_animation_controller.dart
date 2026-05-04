import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class RebecaAnimationController with ChangeNotifier {_animationController = AnimationController with ChangeNotifier {();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  late AnimationController _animationController;_animationController = AnimationController _animationController;();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  late Animation<double> _rebecaAnimation;

  RebecaaddAnimationController(AnimationController(BuildContext context)) {_animationController = AnimationController(AnimationController(BuildContext context)) {();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
    _animationController = AnimationController(_animationController = AnimationController(();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    _rebecaAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  Animation<double> get rebecaAnimation => _rebecaAnimation;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
