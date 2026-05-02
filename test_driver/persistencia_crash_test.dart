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
      final volumeButton = find.byTooltip('Increase volume');
      await driver!.tap(volumeButton);
      await driver!.requestData('crash');
    });
  });
}
