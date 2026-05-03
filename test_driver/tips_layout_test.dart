import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Tips Layout Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('Check tips layout on small screen', () async {
      await driver?.requestData('resize_window', timeout: Duration(seconds: 10));
      await driver?.waitFor(find.text('Dicas'));
      await driver?.waitUntilNoError();
    });
  });
}
