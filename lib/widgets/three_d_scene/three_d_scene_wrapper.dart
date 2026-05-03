import 'package:flutter/material.dart';
import 'package:rebcm/game/widgets/three_d_scene/three_d_scene_logger.dart';

class ThreeDSceneWrapper extends StatefulWidget {
  @override
  _ThreeDSceneWrapperState createState() => _ThreeDSceneWrapperState();
}

class _ThreeDSceneWrapperState extends State<ThreeDSceneWrapper> {
  @override
  Widget build(BuildContext context) {
    return ThreeDSceneLogger(
      child: // Your existing 3D scene widget here,
    );
  }
}
