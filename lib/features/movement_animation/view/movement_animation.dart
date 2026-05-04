import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/movement_animation/controller/movement_animation_controller.dart';

class MovementAnimation extends StatefulWidget {
  @override
  _MovementAnimationState createState() => _MovementAnimationState();
}

class _MovementAnimationState extends State<MovementAnimation> with TickerProviderStateMixin { with AnimationControllerDisposer {_animationController = AnimationControllerDisposer {();
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
    vsync: this,vsync: this);
    _movement_animationAnimationController.dispose();_animationController = AnimationController.dispose();();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
    context.read<MovementAnimationController>(_animationController);_animationController = AnimationController>(_animationController);();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animationController.value * 100, 0),
          child: child,
        );
      },
      child: Icon(Icons.directions_walk),
    );
  }
}
