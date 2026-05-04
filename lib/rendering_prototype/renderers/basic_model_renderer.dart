import 'package:flutter/material.dart';
import 'package:game/rendering_prototype/models/basic_model.dart';

class BasicModelRenderer extends StatefulWidget {
  @override
  _BasicModelRendererState createState() => _BasicModelRendererState();
}

class _BasicModelRendererState extends State<BasicModelRenderer> {
  late BasicModel _model;

  @override
  void initState() {
    super.initState();
    _model = BasicModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Model Renderer'),
      ),
      body: Center(
        child: CustomPaint(
          painter: _ModelPainter(_model),
        ),
      ),
    );
  }
}

class _ModelPainter extends CustomPainter {
  final BasicModel _model;

  _ModelPainter(this._model);

  @override
  void paint(Canvas canvas, Size size) {
    // Implement painting logic here
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 100, height: 100), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
