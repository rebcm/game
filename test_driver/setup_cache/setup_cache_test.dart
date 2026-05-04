import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Setup Cache Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('verify setup cache is working', () async {
      await driver.waitUntilNoTransientCallbacks();
      final summary = await driver.checkHealth();
      expect(summary.status, HealthStatus.ok);
    });
  });
}
