import 'package:flutter/material.dart';
import 'package:game/scenes/3d_scene/3d_scene_logger.dart';

class Annotated3DScene extends StatefulWidget {
  @override
  _Annotated3DSceneState createState() => _Annotated3DSceneState();
}

class _Annotated3DSceneState extends State<Annotated3DScene> {
  final ThreeDSceneLogger _logger = ThreeDSceneLogger();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _logger.logRenderFrame('Scroll notification');
        return true;
      },
      child: RepaintBoundary(
        child: ValueListenableBuilder(
          valueListenable: // existing value listenable,
          builder: (context, value, child) {
            _logger.logRebuild('Value changed');
            return // existing 3D scene widget tree,
          },
        ),
      ),
    );
  }
}
