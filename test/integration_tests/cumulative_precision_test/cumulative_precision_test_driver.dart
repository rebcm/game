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

  test('Cumulative precision test driver', () async {
    await driver?.runUnsynchronized(() async {
      await driver?.requestData('test_cumulative_precision');
    });
  });
}
