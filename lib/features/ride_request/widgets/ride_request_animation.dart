import 'package:flutter/material.dart';

class RideRequestAnimation extends StatefulWidget {
  @override
  _RideRequestAnimationState createState() => _RideRequestAnimationState();
}

class _RideRequestAnimationState extends State<RideRequestAnimation> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
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
        return Transform.scale(
          scale: _animationController.value,
          child: child,
        );
      },
      child: // existing child widget,
    );
  }
}
