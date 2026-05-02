import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/engine_3d/engine_3d.dart';
import 'package:flutter_gl/flutter_gl.dart';

void main() {
  test('Engine3D render test', () {
    FlutterGlContext glContext = FlutterGlContext();
    Engine3D engine3D = Engine3D(glContext);
    engine3D.render();
    // Verificações da renderização
  });
}
