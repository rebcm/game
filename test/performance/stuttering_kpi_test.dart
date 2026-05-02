import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/performance/stuttering_kpi.dart';

void main() {
  group('StutteringKPI', () {
    test('should return true when FPS is less than threshold', () {
      final kpi = StutteringKPI();
      expect(kpi.isStuttering(54, 0), true);
    });

    test('should return true when jank frames is more than threshold', () {
      final kpi = StutteringKPI();
      expect(kpi.isStuttering(60, 11), true);
    });

    test('should return false when FPS and jank frames are within thresholds', () {
      final kpi = StutteringKPI();
      expect(kpi.isStuttering(60, 5), false);
    });
  });
}
