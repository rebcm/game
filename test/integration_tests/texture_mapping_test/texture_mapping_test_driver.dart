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

  test('Texture mapping test', () async {
    await driver?.runUnsynchronized(() async {
      await driver?.requestData('texture_mapping_test');
    });
  });
}
