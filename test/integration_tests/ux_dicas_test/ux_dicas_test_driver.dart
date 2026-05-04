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

  test('UX Dicas Test', () async {
    await driver!.runUnsynchronized(() async {
      // Implementar lógica para executar o teste
    });
  });
}

