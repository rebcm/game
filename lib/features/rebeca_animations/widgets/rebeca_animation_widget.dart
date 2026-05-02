import 'package:flutter/material.dart';
import 'package:passdriver/features/rebeca_animations/rebeca_animations.dart';

class RebecaAnimationWidget extends StatefulWidget {
  @override
  _RebecaAnimationWidgetState createState() => _RebecaAnimationWidgetState();
}

class _RebecaAnimationWidgetState extends State<RebecaAnimationWidget> with TickerProviderStateMixin {
  late RebecaAnimations _rebecaAnimations;

  @override
  void initState() {
    super.initState();
    _rebecaAnimations = RebecaAnimations();
    _rebecaAnimations.initAnimation(this);
  }

  @override
  void dispose() {
    _rebecaAnimations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rebecaAnimations.getAnimation(),
      builder: (context, child) {
        return Transform.scale(
          scale: _rebecaAnimations.getAnimation().value,
          child: child,
        );
      },
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
    );
  }
}
