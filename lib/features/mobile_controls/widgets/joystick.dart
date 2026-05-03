import 'package:flutter/material.dart';

class Joystick extends StatefulWidget {
  final Function(DragUpdateDetails) onDirectionChanged;

  Joystick({required this.onDirectionChanged});

  @override
  _JoystickState createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _offset = details.localPosition;
        });
        widget.onDirectionChanged(details);
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            transform: Matrix4.translationValues(_offset.dx, _offset.dy, 0),
          ),
        ),
      ),
    );
  }
}
