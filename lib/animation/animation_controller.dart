import 'package:flutter/material.dart';
import 'package:game/animation/animation_states.dart';

class AnimationControllerWidget extends StatefulWidget {
  @override
  _AnimationControllerWidgetState createState() => _AnimationControllerWidgetState();
}

class _AnimationControllerWidgetState extends State<AnimationControllerWidget> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return _animationController.value > 0.5
            ? OtherAnimation(key: WidgetKeys.otherAnimation)
            : IdleAnimation(key: WidgetKeys.idleAnimation);
      },
    );
  }
}

class IdleAnimation extends StatelessWidget {
  const IdleAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(); // Implementação da animação idle
  }
}

class OtherAnimation extends StatelessWidget {
  const OtherAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(); // Implementação da outra animação
  }
}
