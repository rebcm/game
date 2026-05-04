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

  test('Teste de Inicialização', () async {
    await driver!.waitFor(find.text('Rebeca'));
  });

  test('Teste de Renderização', () async {
    await driver!.waitFor(find.byType('VoxelBlock'));
  });

  test('Teste de Interação', () async {
    await driver!.tap(find.byType('VoxelBlock'));
    await driver!.waitFor(find.text('Rebeca interagiu com o bloco'));
  });
}

