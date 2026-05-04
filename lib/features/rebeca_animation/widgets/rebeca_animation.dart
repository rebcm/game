import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';
import 'package:simple_animation/simple_animation.dart';

class RebecaAnimation extends StatefulWidget {
  @override
  _RebecaAnimationState createState() => _RebecaAnimationState();
}

class _RebecaAnimationState extends State<RebecaAnimation> with TickerProviderStateMixin { with AnimationControllerDisposer {_animationController = AnimationControllerDisposer {();
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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(_animationController = AnimationController(();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
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
