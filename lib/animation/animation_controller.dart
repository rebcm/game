import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';
import 'package:game/animation/animation_states.dart';

class AnimationControllerWidget extends StatefulWidget {_animationController = AnimationControllerWidget extends StatefulWidget {();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  @override
  _AnimationControllerWidgetState createState() => _AnimationControllerWidgetState();_animationController = AnimationControllerWidgetState createState() => _AnimationControllerWidgetState();();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
}

class _AnimationControllerWidgetState extends State<AnimationControllerWidget> with TickerProviderStateMixin {_animationController = AnimationControllerWidgetState extends State<AnimationControllerWidget> with TickerProviderStateMixin {();
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
    _animationController = AnimationController(vsync: this);_animationController = AnimationController(vsync: this);();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
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
