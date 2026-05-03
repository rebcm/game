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

    test('Tela de dicas não apresenta overflow', () async {
      final dicasButton = find.byValueKey('dicas_button');
      await driver!.tap(dicasButton);

      final dicasText = find.byValueKey('dicas_text');
      await driver!.waitFor(dicasText);

      // Verifica se o texto não apresenta overflow
      final dicasTextSize = await driver!.getTextSize(dicasText);
      expect(dicasTextSize.width, lessThanOrEqualTo(320));
    });
  });
}
