import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Undo/Redo performance test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Undo/Redo performance', () async {
      await driver.runUnsynchronized(() async {
        await driver.tap(find.byValueKey('add_button'));
        await driver.tap(find.byValueKey('undo_button'));
        await driver.tap(find.byValueKey('redo_button'));
      });

      final timeline = await driver.traceAction(() async {
        await driver.tap(find.byValueKey('add_button'));
        await driver.tap(find.byValueKey('undo_button'));
        await driver.tap(find.byValueKey('redo_button'));
      });

      final summary = TimelineSummary.summarize(timeline);
      summary.writeSummaryToFile('undo_redo_performance', pretty: true);
      summary.writeTimelineToFile('undo_redo_performance', pretty: true);

      expect(summary.countFrames(), lessThan(100));
    });
  });
}
