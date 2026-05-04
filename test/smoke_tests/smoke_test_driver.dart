import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    driver?.close();
  });

  test('Smoke test driver', () async {
    final health = await driver?.checkHealth();
    expect(health?.status, HealthStatus.ok);
  });
}
