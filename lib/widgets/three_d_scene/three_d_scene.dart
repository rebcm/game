import 'package:flutter/material.dart';
import 'package:rebcm/game/utils/performance_testing/rebuild_logger.dart';

class ThreeDScene extends StatefulWidget {
  @override
  State<ThreeDScene> createState() => _ThreeDSceneState();
}

class _ThreeDSceneState extends State<ThreeDScene> {
  @override
  Widget build(BuildContext context) {
    return RebuildLoggerWrapper(
      widgetName: 'ThreeDScene',
      child: // existing ThreeDScene content,
    );
  }
}
