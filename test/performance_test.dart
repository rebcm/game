import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/performance_monitor.dart';

void main() {
  testWidgets('Performance test', (tester) async {
    final performanceMonitor = PerformanceMonitor();

    await tester.pumpWidget(MyApp(performanceMonitor: performanceMonitor));

    await tester.pumpAndSettle();

    expect(performanceMonitor.fps, greaterThan(55));
  });
}
