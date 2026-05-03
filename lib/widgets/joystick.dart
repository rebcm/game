import 'package:flutter/material.dart';
import 'package:rebcm/controllers/joystick_controller.dart';

class Joystick extends StatefulWidget {
  @override
  _JoystickState createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  Offset _offset = Offset.zero;
  JoystickController _controller = JoystickController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        _offset = details.localPosition;
        double x = (_offset.dx - 50) / 50;
        double y = (_offset.dy - 50) / 50;
        _controller.update(x, y);
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_controller.x * 40, _controller.y * 40),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
