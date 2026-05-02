import 'package:test/test.dart';
import 'package:rebcm/engine_3d/engine_3d.dart';
import 'package:flutter_gl/flutter_gl.dart';

void main() {
  group('Engine3D', () {
    late FlutterGlContext _glContext;
    late Engine3D _engine3D;

    setUp(() {
      _glContext = FlutterGlContext();
      _engine3D = Engine3D(_glContext);
    });

    test('renderiza corretamente', () {
      _engine3D.render();
      // Verificações necessárias
    });
  });
}
