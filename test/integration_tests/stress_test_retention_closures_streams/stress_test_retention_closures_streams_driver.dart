import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Stress test for retention of closures and streams', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Stress test', () async {
      await driver.runUnsynchronized(() async {
        await driver.tap(find.text('Trigger Closure'));
        await Future.delayed(const Duration(seconds: 1));
        expect(await driver.getText(find.text('Expected Outcome')), 'Expected Outcome');
      });
    });
  });
}
