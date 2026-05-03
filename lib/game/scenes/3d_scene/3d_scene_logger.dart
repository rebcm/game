import 'package:flutter/material.dart';

class ThreeDSceneLogger with Diagnosticable {
  int _rebuildCount = 0;

  void logRebuild() {
    _rebuildCount++;
    debugPrint('3D Scene Rebuild Count: $_rebuildCount');
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('Rebuild Count', _rebuildCount));
  }
}
