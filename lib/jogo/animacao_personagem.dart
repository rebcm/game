import 'package:flutter/material.dart';
import 'package:rebcm/personagem/rebeca.dart';

class AnimacaoPersonagem extends StatefulWidget {
  final Rebeca rebeca;

  const AnimacaoPersonagem({Key? key, required this.rebeca}) : super(key: key);

  @override
  _AnimacaoPersonagemState createState() => _AnimacaoPersonagemState();
}

class _AnimacaoPersonagemState extends State<AnimacaoPersonagem> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, 10 * _animationController.value),
            child: widget.rebeca,
          );
        },
      ),
    );
  }
}
