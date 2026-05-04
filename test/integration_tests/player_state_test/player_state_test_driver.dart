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

  test('player state integration test', () async {
    await driver?.runUnsynchronized(() async {
      await driver?.waitFor(find.text('Current Music'));
    });
  });
}
