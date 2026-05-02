import 'package:flutter/material.dart';

class RideAnimation extends StatefulWidget {
  @override
  _RideAnimationState createState() => _RideAnimationState();
}

class _RideAnimationState extends State<RideAnimation> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 100).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void updateSpeed(double speed) {
    _animationController.animateTo(speed / 100);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: // existing widget tree,
    );
  }
}
