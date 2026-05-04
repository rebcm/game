import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('i18n layout test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('check detailed description layout', () async {
      final detailedDescriptionFinder = find.byValueKey('detailed_description');
      await driver.waitFor(detailedDescriptionFinder);
      final detailedDescriptionText = await driver.getText(detailedDescriptionFinder);
      expect(detailedDescriptionText, isNotEmpty);
    });

    test('check detailed description layout with different locales', () async {
      final localeButtonFinder = find.byValueKey('locale_button');
      await driver.waitFor(localeButtonFinder);
      await driver.tap(localeButtonFinder);

      final frenchLocaleFinder = find.byValueKey('fr_FR');
      await driver.waitFor(frenchLocaleFinder);
      await driver.tap(frenchLocaleFinder);

      final detailedDescriptionFinder = find.byValueKey('detailed_description');
      await driver.waitFor(detailedDescriptionFinder);
      final detailedDescriptionText = await driver.getText(detailedDescriptionFinder);
      expect(detailedDescriptionText, isNotEmpty);

      // Add more locale tests as needed
    });
  });
}
