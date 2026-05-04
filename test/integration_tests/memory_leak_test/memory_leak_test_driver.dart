import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      await driver?.close();
    }
  });

  test('Memory Leak Test', () async {
    final timeline = await driver?.traceAction(() async {
      await driver?.requestData('memory_leak_test');
    });
    // Analyze timeline for memory usage
  });
}
