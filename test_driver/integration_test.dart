import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Responsividade Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver?.close();
      }
    });

    test('Testa responsividade em tela pequena', () async {
      final width = await driver?.getDisplaySize().then((size) => size.width);
      expect(width, lessThan(320));
    });
  });
}
