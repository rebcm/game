import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class JoystickWidget extends HookWidget {
  final Function(double, double) onJoystickChange;

  const JoystickWidget({Key? key, required this.onJoystickChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final joystickOffset = useState(Offset.zero);
    final isDragging = useState(false);

    void handlePanStart(DragStartDetails details) {
      isDragging.value = true;
      joystickOffset.value = details.localPosition;
    }

    void handlePanUpdate(DragUpdateDetails details) {
      joystickOffset.value = details.localPosition;
      final dx = (joystickOffset.value.dx - 50) / 50;
      final dy = (joystickOffset.value.dy - 50) / 50;
      final deadzone = 0.1;
      if (dx.abs() > deadzone || dy.abs() > deadzone) {
        onJoystickChange(dx, dy);
      } else {
        onJoystickChange(0, 0);
      }
    }

    void handlePanEnd(DragEndDetails details) {
      isDragging.value = false;
      joystickOffset.value = Offset.zero;
      onJoystickChange(0, 0);
    }

    return GestureDetector(
      onPanStart: handlePanStart,
      onPanUpdate: handlePanUpdate,
      onPanEnd: handlePanEnd,
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
            transform: Matrix4.translationValues(joystickOffset.value.dx - 50, joystickOffset.value.dy - 50, 0),
          ),
        ),
      ),
    );
  }
}
