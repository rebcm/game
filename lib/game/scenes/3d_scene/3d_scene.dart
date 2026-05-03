import 'package:flutter/material.dart';
import 'package:game/scenes/3d_scene/3d_scene_logger.dart';

class ThreeDScene extends StatefulWidget {
  @override
  _ThreeDSceneState createState() => _ThreeDSceneState();
}

class _ThreeDSceneState extends State<ThreeDScene> {
  final ThreeDSceneLogger _logger = ThreeDSceneLogger();

  @override
  Widget build(BuildContext context) {
    _logger.logRebuild();
    // Existing 3D scene build logic here
    return Container(); // Placeholder
  }
}
