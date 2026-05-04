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

  test('logging integration test', () async {
    // Use driver to interact with the app and test logging
    await driver?.tap(find.text('Trigger Log'));
    // Verify logging output
  });
}
