import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Onboarding Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Clean Installation Test on Multiple OS', () async {
      await driver.waitUntilFirstFrameRasterized();

      // Check if the app launches successfully
      await driver.waitFor(find.text('Rebeca\'s Creative Building'));

      // Check if the initial screen is rendered correctly
      await driver.waitFor(find.byType('GridView'));

      // Perform a simple interaction to verify functionality
      await driver.tap(find.byType('FloatingActionButton'));
      await driver.waitFor(find.text('Block Placed'));

      // Verify that the onboarding process completes successfully
      await driver.waitFor(find.text('Onboarding Complete'));
    });
  });
}
