import 'package:flutter/material.dart';
import 'package:game/widgets/three_d_scene/three_d_scene.dart';
import 'package:game/widgets/three_d_scene/three_d_scene_logger.dart';

class ThreeDSceneWrapper extends StatefulWidget {
  @override
  _ThreeDSceneWrapperState createState() => _ThreeDSceneWrapperState();
}

class _ThreeDSceneWrapperState extends State<ThreeDSceneWrapper> {
  final ThreeDSceneLogger _logger = ThreeDSceneLogger();

  @override
  Widget build(BuildContext context) {
    _logger.logRebuild();
    return ThreeDScene();
  }
}
