import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Idle Animation Performance Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Idle animation performance test', () async {
      final animationFinder = find.byValueKey('idle_animation');
      await driver.waitFor(animationFinder);
      final timeline = await driver.traceAction(() async {
        await driver.runUnsynchronized(() async {
          for (var i = 0; i < 100; i++) {
            await Future.delayed(Duration(milliseconds: 100));
          }
        });
      });
      final summary = TimelineSummary.summarize(timeline);
      summary.writeSummaryToFile('idle_animation_performance', pretty: true);
      summary.writeTimelineToFile('idle_animation_performance', pretty: true);
    });
  });
}
