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

  test('Retention Test', () async {
    await driver?.runUnsynchronized(() async {
      await driver?.tap(find.text('Retention Test'));
    });
  });
}
