import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Integration test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver?.close();
      }
    });

    test('Integration test', () async {
      // Implement your test logic here
      expect(await driver?.getText(find.byText('Rebeca')), 'Rebeca');
    });
  });
}
