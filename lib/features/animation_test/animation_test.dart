import 'package:flutter/material.dart';

class AnimationTest extends StatefulWidget {
  @override
  _AnimationTestState createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest> with TickerProviderStateMixin { with AnimationControllerDisposer {
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

  void _animateToIdle() {
    _animationController.animateTo(0.0);
  }

  void _animateToOtherState() {
    _animationController.animateTo(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _animationController.value,
              child: child,
            );
          },
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
        ),
        ElevatedButton(
          onPressed: _animateToIdle,
          child: Text('Idle'),
        ),
        ElevatedButton(
          onPressed: _animateToOtherState,
          child: Text('Other State'),
        ),
      ],
    );
  }
}
