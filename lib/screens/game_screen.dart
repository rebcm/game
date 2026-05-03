import 'package:flutter/material.dart';
import 'package:rebcm/widgets/joystick.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Other game elements...
          Positioned(
            bottom: 20,
            left: 20,
            child: Joystick(),
          ),
        ],
      ),
    );
  }
}
