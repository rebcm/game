import 'package:flutter_gl/flutter_gl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Flutter GL compatibility test', () async {
    final glView = FlutterGLView();
    expect(glView, isNotNull);
  });
}
