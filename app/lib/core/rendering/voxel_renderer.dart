import 'package:flame/game.dart';
import 'package:flutter_gl/flutter_gl.dart';

class VoxelRenderer {
  late FlutterGlContext _glContext;

  void init() {
    _glContext = FlutterGlContext();
    _glContext.init();
  }

  void render() {
    _glContext.makeCurrent();
    // Render 3D voxel world
  }

  void dispose() {
    _glContext.dispose();
  }
}
