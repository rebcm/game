import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Teste de retenção', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test('deve disparar política de retenção após upload de binários', () async {
      await driver!.waitUntilNoTransientCallbacks();
      await driver!.tap(find.byValueKey('upload_binarios'));
      await driver!.waitFor(find.text('Política de retenção disparada'));
    });
  });
}
