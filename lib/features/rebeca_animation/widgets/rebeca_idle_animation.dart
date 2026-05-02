import 'package:flutter/material.dart';
import 'package:passdriver/features/rebeca_animation/rebeca_animation_controller.dart';

class RebecaIdleAnimation extends StatefulWidget {
  const RebecaIdleAnimation({super.key});

  @override
  State<RebecaIdleAnimation> createState() => _RebecaIdleAnimationState();
}

class _RebecaIdleAnimationState extends State<RebecaIdleAnimation> with TickerProviderStateMixin { with AnimationControllerDisposer {
  late RebecaAnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = RebecaaddAnimationController(AnimationController(context));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController.rebecaAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animationController.rebecaAnimation.value, 0),
          child: child,
        );
      },
      child: Image.asset('assets/images/rebeca.png'), // Certifique-se de que o caminho da imagem está correto no pubspec.yaml
    );
  }
}
