import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('App Startup Performance Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test('app startup time', () async {
      final startTime = DateTime.now();
      await driver!.waitUntilFirstFrameRasterized();
      final endTime = DateTime.now();
      final startupTime = endTime.difference(startTime).inMilliseconds;
      expect(startupTime, lessThan(2000)); // 2 segundos
    });
  });
}

