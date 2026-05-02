import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/lighting/sun_light.dart';

void main() {
  group('SunLight', () {
    test('initial direction is correct', () {
      final sunLight = SunLight();
      expect(sunLight._direction, Vector3(1, -1, 1));
    });

    test('initial color is correct', () {
      final sunLight = SunLight();
      expect(sunLight._color, Color.fromRGBO(255, 255, 255, 1));
    });
  });
}
