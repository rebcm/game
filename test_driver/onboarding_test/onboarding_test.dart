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

    test('Onboarding completes successfully', () async {
      await driver.waitUntilFirstFixFrame();
      await driver.tap(find.byTooltip('Next'));
      await driver.tap(find.byTooltip('Start'));
      await driver.waitFor(find.text('Welcome to the game!'));
    });
  });
}
