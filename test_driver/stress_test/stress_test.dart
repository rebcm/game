import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Stress Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver?.close();
    });

    test('Chunk Rendering Stress Test', () async {
      await driver?.requestData('start_stress_test');
      await Future.delayed(Duration(hours: 1)); // Run for 1 hour
    }, timeout: Timeout(Duration(hours: 2)));
  });
}
