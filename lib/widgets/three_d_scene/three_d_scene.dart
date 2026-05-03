import 'package:flutter/material.dart';
import 'package:game/widgets/three_d_scene/rebuild_logger_wrapper.dart';

class ThreeDScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RebuildLoggerWrapper(
      widgetName: 'ThreeDScene',
      child: // existing 3D scene widget tree,
    );
  }
}
