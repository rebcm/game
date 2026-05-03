import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Text Overflow Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('Validate text rendering in German and French', () async {
      await driver?.waitFor(find.text('Rebeca')); // Initial text to wait for
      await driver?.tap(find.text('Settings')); // Navigate to settings
      await driver?.waitFor(find.text('Language')); // Wait for language option
      await driver?.tap(find.text('Deutsch')); // Select German
      await driver?.waitFor(find.text('Einstellungen')); // Validate German text
      await driver?.tap(find.text('Language')); // Revisit language option
      await driver?.tap(find.text('Français')); // Select French
      await driver?.waitFor(find.text('Paramètres')); // Validate French text
    });
  });
}
