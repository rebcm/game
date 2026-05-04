import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver!.close();
    }
  });

  test('Guia de Construção', () async {
    final guiaConstrucaoFinder = find.byValueKey('guia_construcao');
    await driver!.waitFor(guiaConstrucaoFinder);
  });
}
