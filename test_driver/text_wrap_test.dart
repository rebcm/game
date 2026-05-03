import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Text Wrap Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test('Text wraps correctly in German', () async {
      await driver!.tap(find.byValueKey('settings_button'));
      await driver!.tap(find.byValueKey('language_dropdown'));
      await driver!.tap(find.text('Deutsch'));
      await driver!.waitFor(find.text('Einstellungen'));
      await driver!.waitUntilNoTransientCallbacks();
      expect(await driver!.getText(find.byValueKey('test_text')), isNot(contains('...')));
    });
  });
}
