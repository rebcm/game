import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/performance/stuttering_kpi.dart';

void main() {
  group('StutteringKPI', () {
    test('should be stuttering when FPS is less than min', () {
      expect(StutteringKPI.isStuttering(54, 0.0), true);
    });

    test('should not be stuttering when FPS is equal to min', () {
      expect(StutteringKPI.isStuttering(55, 0.0), false);
    });

    test('should be stuttering when jank frames percentage is greater than max', () {
      expect(StutteringKPI.isStuttering(60, 0.06), true);
    });

    test('should not be stuttering when jank frames percentage is equal to max', () {
      expect(StutteringKPI.isStuttering(60, 0.05), false);
    });
  });
}
