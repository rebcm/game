import 'package:flutter/material.dart';
import 'package:rebcm/widgets/animated/optimized_animation.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OptimizedAnimation(),
      ),
    );
  }
}
