import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';
import 'package:passdriver/features/rebeca_animation/rebeca_animation_controller.dart';

class RebecaIdleAnimation extends StatefulWidget {
  const RebecaIdleAnimation({super.key});

  @override
  State<RebecaIdleAnimation> createState() => _RebecaIdleAnimationState();
}

class _RebecaIdleAnimationState extends State<RebecaIdleAnimation> with TickerProviderStateMixin { with AnimationControllerDisposer {_animationController = AnimationControllerDisposer {();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  late RebecaAnimationController _animationController;_animationController = AnimationController _animationController;();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }

  @override
  void initState() {
    super.initState();
    _animationController = RebecaaddAnimationController(AnimationController(context));_animationController = AnimationController(AnimationController(context));();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
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
