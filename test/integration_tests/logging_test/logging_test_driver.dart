import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('LoggingCollector Driver', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver!.close();
      }
    });

    test('should verify log collection', () async {
      final logCollector = await driver!.waitFor(find.byTooltip('Log Collector'));
      await driver!.tap(logCollector);
      final logs = await driver!.getText(find.byTooltip('Logs'));
      expect(logs, isNotEmpty);
    });
  });
}
