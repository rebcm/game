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

  test('D1/R2 integration test', () async {
    await driver?.runUnsynchronized(() async {
      await driver?.waitFor(find.text('Record Created'));
      await driver?.waitFor(find.text('Chunk Uploaded'));
    });
  });
}
