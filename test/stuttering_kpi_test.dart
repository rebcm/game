import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/stuttering_kpi.dart';

void main() {
  group('StutteringKPI', () {
    test('should be considered stuttering if FPS is below threshold', () {
      expect(StutteringKPI.isStuttering(54, 0), true);
    });

    test('should be considered stuttering if jank frames exceed threshold', () {
      expect(StutteringKPI.isStuttering(60, 11), true);
    });

    test('should not be considered stuttering if both metrics are within thresholds', () {
      expect(StutteringKPI.isStuttering(60, 5), false);
    });
  });
}
