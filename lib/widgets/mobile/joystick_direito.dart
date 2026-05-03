import 'package:flutter/material.dart';

class JoystickDireito extends StatefulWidget {
  @override
  _JoystickDireitoState createState() => _JoystickDireitoState();
}

class _JoystickDireitoState extends State<JoystickDireito> {
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
          color: Colors.red.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            transform: Matrix4.translationValues(_offset.dx, _offset.dy, 0),
          ),
        ),
      ),
    );
  }
}
