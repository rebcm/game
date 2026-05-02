import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RebecaIdleAnimation extends StatefulWidget {
  @override
  _RebecaIdleAnimationState createState() => _RebecaIdleAnimationState();
}

class _RebecaIdleAnimationState extends State<RebecaIdleAnimation> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 0, end: 0.1).animate(_animationController);
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RotationTransition(
          turns: _animation,
          child: Image.asset('assets/rebeca.png'),
        ),
      ),
    );
  }
}
