import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class RebecaPlayer extends StatefulWidget {
  @override
  _RebecaPlayerState createState() => _RebecaPlayerState();
}

class _RebecaPlayerState extends State<RebecaPlayer> with TickerProviderStateMixin {
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
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animationController.value * 10, 0),
          child: child,
        );
      },
      child: Image.asset('assets/characters/rebeca_skin.png'),
    );
  }
}
