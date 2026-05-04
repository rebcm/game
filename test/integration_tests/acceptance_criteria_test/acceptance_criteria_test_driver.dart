import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('acceptance criteria test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('verify acceptance criteria', () async {
      // Implement acceptance criteria verification logic here
      final rebecaText = await driver?.getText(find.byText('Rebeca'));
      expect(rebecaText, 'Rebeca');
    });
  });
}
