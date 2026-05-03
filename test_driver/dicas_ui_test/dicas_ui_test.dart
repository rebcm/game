import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Dicas UI Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test('Renderização de texto das dicas', () async {
      final dicasFinder = find.byValueKey('dicas_text');
      await driver!.waitFor(dicasFinder);
      expect(await driver!.getText(dicasFinder), isNotEmpty);
    });
  });
}
