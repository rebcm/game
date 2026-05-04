import 'package:flutter_test/flutter_test.dart';
import 'package:game/constants/epsilon.dart';

void main() {
  group('Epsilon', () {
    test('defaultEpsilon is correctly defined', () {
      expect(Epsilon.defaultEpsilon, 0.0001);
    });

    test('collisionDetection epsilon is correctly defined', () {
      expect(Epsilon.collisionDetection, Epsilon.defaultEpsilon);
    });
  });
}
