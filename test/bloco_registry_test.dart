import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/bloco_registry.dart';

void main() {
  test('should return list of blocos', () {
    final blocos = BlocoRegistry.getBlocos();
    expect(blocos, isA<List<String>>());
  });
}
