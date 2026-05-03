import 'package:flutter/material.dart';
import 'package:rebcm/features/mobile_controls/mobile_controls.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Game content here
          MobileControls(),
        ],
      ),
    );
  }
}
