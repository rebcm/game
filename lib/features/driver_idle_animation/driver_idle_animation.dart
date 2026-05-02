import Intl.message('package:flutter/material.dart');
class DriverIdleAnimation extends StatefulWidget {
  @override
  _DriverIdleAnimationState createState() => _DriverIdleAnimationState();
}
class _DriverIdleAnimationState extends State<DriverIdleAnimation> with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat();
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
        return Transform.rotate(
          angle: _animationController.value * 0.1,
          child: Image.asset(Intl.message('assets/images/rebeca.png')),
        );
      },
    );
  }
}
