import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Dicas Validação Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('Verifica se as dicas são exibidas corretamente', () async {
      final dicasFinder = find.byValueKey('dicas');
      await driver?.waitFor(dicasFinder);
      expect(await driver?.getText(dicasFinder), isNotEmpty);
    });

    test('Verifica se as dicas mudam ao clicar no botão de próxima dica', () async {
      final proximaDicaFinder = find.byValueKey('proximaDica');
      final dicasFinder = find.byValueKey('dicas');
      final primeiraDica = await driver?.getText(dicasFinder);
      await driver?.tap(proximaDicaFinder);
      await Future.delayed(const Duration(milliseconds: 500));
      final segundaDica = await driver?.getText(dicasFinder);
      expect(segundaDica, isNot(primeiraDica));
    });
  });
}
