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

  test('Check for runtime errors during app startup', () async {
    final logs = await driver?.logAll();
    expect(logs, isNot(contains('Error')));
  });
}
