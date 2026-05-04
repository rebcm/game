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

  test('UV mapping validation test driver', () async {
    await driver?.runUnsynchronized(() async {
      await driver?.requestData('uv_mapping_validation_test');
    });
  });
}
