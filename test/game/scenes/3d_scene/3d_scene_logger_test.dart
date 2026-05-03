import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/scenes/3d_scene/3d_scene_logger.dart';

void main() {
  test('ThreeDSceneLogger logs rebuild count', () {
    final logger = ThreeDSceneLogger();
    logger.logRebuild();
    expect(logger.toString(), contains('Rebuild Count: 1'));
  });
}
