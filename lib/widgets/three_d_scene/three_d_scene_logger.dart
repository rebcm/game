import 'package:flutter/material.dart';

class ThreeDSceneLogger with Diagnosticable {
  int _rebuildCount = 0;

  void logRebuild() {
    _rebuildCount++;
    // print('Rebuild count: ');
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('Rebuild count', _rebuildCount));
  }
}
