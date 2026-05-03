import 'package:flutter/material.dart';
import 'package:rebcm/game/utils/performance_testing/rebuild_logger.dart';

class ThreeDScene extends StatefulWidget {
  @override
  _ThreeDSceneState createState() => _ThreeDSceneState();
}

class _ThreeDSceneState extends State<ThreeDScene> {
  final RebuildLogger _rebuildLogger = RebuildLogger('ThreeDScene');

  @override
  Widget build(BuildContext context) {
    _rebuildLogger.logRebuild();
    // Existing build logic here
    return Container();
  }
}
