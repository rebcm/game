import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class RebecaAnimationController with ChangeNotifier {
  late AnimationController _animationController;
  late Animation<double> _rebecaAnimation;

  RebecaAnimationController(BuildContext context) {
    _animationController = AnimationController(
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
