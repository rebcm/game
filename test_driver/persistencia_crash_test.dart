import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Persistência Crash Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver!.close();
      }
    });

    test('Simular crash após alterar volume', () async {
      final volumeLocator = find.byValueKey('volume_slider');
      final saveButtonLocator = find.byValueKey('save_button');

      await driver!.waitFor(volumeLocator);
      await driver!.tap(volumeLocator);
      await driver!.tap(saveButtonLocator);

      // Simular crash do app
      await driver!.requestData('crash');

      // Verificar se o dado foi persistido
      await driver!.waitUntilFirstFrameRasterized();
      final volumeValue = await driver!.getText(find.byValueKey('volume_value'));
      expect(volumeValue, isNot('0')); // Ajuste conforme o valor esperado
    });
  });
}
