import 'package:flutter/material.dart';

class JoystickEsquerdo extends StatefulWidget {
  @override
  _JoystickEsquerdoState createState() => _JoystickEsquerdoState();
}

class _JoystickEsquerdoState extends State<JoystickEsquerdo> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _offset = details.localPosition;
        });
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            transform: Matrix4.translationValues(_offset.dx, _offset.dy, 0),
          ),
        ),
      ),
    );
  }
}
