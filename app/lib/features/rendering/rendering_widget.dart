import 'package:flutter/material.dart';

class RenderingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RenderingPainter(),
      size: Size.infinite,
    );
  }
}

class RenderingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: 100,
        height: 100,
      ),
      paint,
    );

    paint.color = Colors.red;
    canvas.drawCircle(
      Offset(centerX, centerY),
      50,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
