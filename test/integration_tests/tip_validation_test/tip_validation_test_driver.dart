import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Tip Validation Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver?.close();
      }
    });

    test('Validate tip interaction', () async {
      final tipFinder = find.byText('Dica: Construa sua estrutura aqui!');
      await driver?.waitFor(tipFinder);

      final closeTipButton = find.byIcon(Icons.close);
      await driver?.tap(closeTipButton);

      await driver?.waitForAbsent(tipFinder);
    });
  });
}
