import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/movement_animation/controller/movement_animation_controller.dart';

class MovementAnimation extends StatefulWidget {
  @override
  _MovementAnimationState createState() => _MovementAnimationState();
}

class _MovementAnimationState extends State<MovementAnimation> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
    vsync: this,vsync: this);
    _movement_animationAnimationController.dispose();
    context.read<MovementAnimationController>(_animationController);
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
