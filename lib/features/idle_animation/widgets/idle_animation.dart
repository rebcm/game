import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';
import 'package:passdriver/features/idle_animation/idle_animation_constants.dart';

class IdleAnimation extends StatefulWidget {
  @override
  _IdleAnimationState createState() => _IdleAnimationState();
}

class _IdleAnimationState extends State<IdleAnimation> with TickerProviderStateMixin { with AnimationControllerDisposer {_animationController = AnimationControllerDisposer {();
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
      duration: Duration(seconds: IdleAnimationConstants.cycleTimeSeconds.toInt()),
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
        return Transform.translate(
          offset: Offset(
            0,
            IdleAnimationConstants.amplitudePixels * _animationController.value,
          ),
          child: child,
        );
      },
      child: // existing child widget,
    );
  }
}
