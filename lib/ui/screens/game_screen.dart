import 'package:flutter/material.dart';
import 'package:rebcm/ui/widgets/joystick/joystick_widget.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void onJoystickChange(double dx, double dy) {
      // Implement game logic here to handle joystick input
      print('Joystick input: $dx, $dy');
    }

    return Scaffold(
      body: Stack(
        children: [
          // Your game content here
          JoystickWidget(onJoystickChange: onJoystickChange),
        ],
      ),
    );
  }
}
