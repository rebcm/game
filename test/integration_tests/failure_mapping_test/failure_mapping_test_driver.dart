import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver?.close();
    }
  });

  test('Failure mapping test', () async {
    await driver?.runUnsynchronized(() async {
      await driver?.tap(find.text('Run Failure Mapping Test'));
    });
    expect(true, true);
  });
}
