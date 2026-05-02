import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_gl/flutter_gl.dart';

class FlameLoopIntegrationWidget extends StatefulWidget {
  @override
  _FlameLoopIntegrationWidgetState createState() => _FlameLoopIntegrationWidgetState();
}

class _FlameLoopIntegrationWidgetState extends State<FlameLoopIntegrationWidget> {
  late FlutterGLContext _glContext;
  late FlameGame _game;

  @override
  void initState() {
    super.initState();
    _glContext = FlutterGLContext();
    _game = FlameGame(
      // Initialize game with proper configuration
    );
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: _game,
    );
  }

  @override
  void dispose() {
    _glContext.dispose();
    super.dispose();
  }
}
