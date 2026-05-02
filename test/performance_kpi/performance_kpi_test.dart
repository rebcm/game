import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/performance_kpi.dart';

void main() {
  group('PerformanceKPI', () {
    test('getFpsThreshold returns correct value', () async {
      final fpsThreshold = await PerformanceKPI.getFpsThreshold();
      expect(fpsThreshold, isA<int>());
    });

    test('getJankFramesThreshold returns correct value', () async {
      final jankFramesThreshold = await PerformanceKPI.getJankFramesThreshold();
      expect(jankFramesThreshold, isA<int>());
    });

    test('isStuttering returns correct value', () async {
      final isStuttering = await PerformanceKPI.isStuttering(50, 11);
      expect(isStuttering, true);
    });
  });
}
