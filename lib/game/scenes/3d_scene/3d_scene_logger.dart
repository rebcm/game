import 'package:flutter/material.dart';

class ThreeDSceneLogger with DiagnosticableTreeMixin {
  void logRebuild(String message) {
    debugPrint('3D Scene Rebuild: $message');
  }

  void logRenderFrame(String message) {
    debugPrint('3D Scene Render Frame: $message');
  }
}
