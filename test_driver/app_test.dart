import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('App Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect(timeout: Duration(seconds: 300));
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Test with retries and timeout', () async {
      await driver.waitFor(find.text('Rebeca'), timeout: Duration(seconds: 10));
    }, timeout: Timeout(Duration(seconds: 300)), retry: 3);
  });
}
