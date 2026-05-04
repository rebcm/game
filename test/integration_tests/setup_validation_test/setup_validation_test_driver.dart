import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Setup Validation Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver?.close();
    });

    test('check initial screen', () async {
      final welcomeText = await driver?.getText(find.byValueKey('welcome_text'));
      expect(welcomeText, 'Rebeca');
    });
  });
}
