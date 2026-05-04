import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Undo/Redo Performance Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Undo/Redo rebuilds are within acceptable limits', () async {
      final undoButton = find.byTooltip('Undo');
      final redoButton = find.byTooltip('Redo');

      await driver.waitFor(undoButton);
      await driver.waitFor(redoButton);

      final timeline = await driver.traceAction(() async {
        for (int i = 0; i < 10; i++) {
          await driver.tap(undoButton);
          await driver.tap(redoButton);
        }
      });

      final summary = await TimelineSummary.summarize(timeline);
      await summary.writeSummaryToFile('undo_redo_performance_test', pretty: true);
      await summary.writeTimelineToFile('undo_redo_performance_test', pretty: true);

      final rebuildCount = await driver.getRenderObjectDiagnostics(find.byType('YourWidget'), 'rebuildCount');
      expect(rebuildCount, isNotNull);
      expect(int.parse(rebuildCount!), lessThan(100)); // Adjust the threshold as needed
    });
  });
}
