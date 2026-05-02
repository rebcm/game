import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('App Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect(timeout: Duration(seconds: 10));
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Test App Edge Cases', () async {
      await driver.waitUntilFirstFrameRasterized(timeout: Duration(seconds: 30));

      // Example test step with retry
      await driver.waitFor(find.text('Rebeca'), timeout: Duration(seconds: 10)).timeout(Duration(seconds: 15), onTimeout: () {
        fail('Timeout waiting for Rebeca text');
      }).then((value) {
        expect(value, isNotNull);
      }).catchError((error) {
        fail('Error waiting for Rebeca text: $error');
      });
    }, timeout: Timeout(Duration(seconds: 60)), retry: 3);
  });
}
