import 'package:flutter_test/flutter_test.dart';
import 'package:game/constants/epsilon.dart';

void main() {
  test('Epsilon default value is correct', () {
    expect(Epsilon.defaultEpsilon, 0.0001);
  });
}
