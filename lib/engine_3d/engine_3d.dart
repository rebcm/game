import 'package:flutter_gl/flutter_gl.dart';

class Engine3D {
  late FlutterGlContext _glContext;

  Engine3D(this._glContext);

  void render() {
    // Implementação da renderização 3D
    _glContext.clearColor(1.0, 1.0, 1.0, 1.0);
    _glContext.clear(0x00004000);
  }

  void update() {
    // Implementação da atualização da engine 3D
  }
}
