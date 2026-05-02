import 'package:flutter/material.dart';
import 'package:simple_animation/simple_animation.dart';

class RebecaAnimation extends StatefulWidget {
  @override
  _RebecaAnimationState createState() => _RebecaAnimationState();
}

class _RebecaAnimationState extends State<RebecaAnimation> with TickerProviderStateMixin { with AnimationControllerDisposer {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animationController.value * 0.1,
          child: child,
        );
      },
      child: Image.asset('assets/rebeca.png'),
    );
  }
}
