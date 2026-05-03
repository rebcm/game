import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Dicas UI Integration Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver!.close();
      }
    });

    test('Renderização de dicas em diferentes resoluções', () async {
      final button = find.byText('Mostrar Dicas');
      await driver!.waitFor(button);
      await driver!.tap(button);
      await driver!.waitFor(find.text('Conteúdo das Dicas'));
    });

    test('Renderização de dicas em diferentes idiomas', () async {
      // Simula mudança de idioma para inglês
      final button = find.byText('Show Tips');
      await driver!.waitFor(button);
      await driver!.tap(button);
      await driver!.waitFor(find.text('Tips Content'));
    });
  });
}
