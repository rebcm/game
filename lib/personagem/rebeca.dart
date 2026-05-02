import 'package:flutter/material.dart';

class Rebeca extends StatefulWidget {
  @override
  void dispose() { 
    // Dispose AnimationControllers here
    super.dispose();
  }
  static double velocidade = 0;

  @override
  _RebecaState createState() => _RebecaState();
}

class _RebecaState extends State<Rebeca> with TickerProviderStateMixin { with AnimationControllerDisposer {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(Rebeca.velocidade, 0),
          child: child,
        );
      },
      child: Container(), // Implemente o widget da Rebeca aqui
    );
  }
}
