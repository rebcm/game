import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    await driver?.close();
  });

  test('Memory leak test driver', () async {
    await driver?.runUnsynchronized(() async {
      await driver?.requestData('some_data');
    });
  });
}
