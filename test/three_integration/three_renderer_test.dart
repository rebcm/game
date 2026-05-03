import 'package:flutter_test/flutter_test.dart';
import 'package:game/three_integration/three_renderer.dart';

void main() {
  test('ThreeRenderer initialization', () {
    final renderer = ThreeRenderer();
    renderer.init();
    expect(renderer, isNotNull);
  });
}

