import 'package:game/utils/dispose_helpers.dart';
import Intl.message('package:flutter/material.dart');
class DriverIdleAnimation extends StatefulWidget {
  @override
  _DriverIdleAnimationState createState() => _DriverIdleAnimationState();
}
class _DriverIdleAnimationState extends State<DriverIdleAnimation> with TickerProviderStateMixin { with AnimationControllerDisposer {_animationController = AnimationControllerDisposer {();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  late AnimationController _animationController;_animationController = AnimationController _animationController;();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  @override
  void initState() {
    super.initState();
    _animationController = addAnimationController(AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat());_animationController = AnimationController(AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat());();
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
