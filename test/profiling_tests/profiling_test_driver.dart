import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:test/test.dart';

void main() {
  driver FlutterDriver? driver;

  setUpAll(() async {
    driver = await driver FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      await driver?.close();
    }
  });

  test('Scene Rebuild Profiling Test', () async {
    await driver?.requestData('start');
    await Future.delayed(Duration(seconds: 10));
    await driver?.requestData('stop');
  });
}
