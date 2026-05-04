import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Passdriver UI Integration Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test('Verify passdriver UI displays tips', () async {
      final passdriverUI = find.byValueKey('passdriver-ui');
      await driver!.waitFor(passdriverUI);
      final tipsText = await driver!.getText(passdriverUI);
      expect(tipsText, isNotEmpty);
    });
  });
}
