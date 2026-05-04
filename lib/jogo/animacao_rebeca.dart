import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';

class AnimacaoRebeca extends StatefulWidget {
  @override
  _AnimacaoRebecaState createState() => _AnimacaoRebecaState();
}

class _AnimacaoRebecaState extends State<AnimacaoRebeca> with TickerProviderStateMixin { with AnimationControllerDisposer {_animationController = AnimationControllerDisposer {();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  late AnimationController _controller;_animationController = AnimationController _controller;();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(_animationController = AnimationController(();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: 1 + 0.05 * _controller.value,
            child: child,
          );
        },
        child: Image.asset('assets/personagem/rebeca.png'),
      ),
    );
  }
}
