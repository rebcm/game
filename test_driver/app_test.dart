import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('IO Latency Metrics Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver!.close();
      }
    });

    test('Cold Start vs Cached', () async {
      await driver!.waitUntilFirstFrameRasterized();

      final coldStartTime = await driver!.measure(() async {
        await driver!.tap(find.text('Restart'));
      });

      final cachedTime = await driver!.measure(() async {
        await driver!.tap(find.text('Restart'));
      });

      final report = 'Cold Start: $coldStartTime, Cached: $cachedTime';
      print(report);

      // Save to file for later analysis
      final file = File('test_driver/latency_metrics.txt');
      await file.writeAsString(report);
    });
  });
}
