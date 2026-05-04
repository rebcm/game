import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    driver?.close();
  });

  test('Tips trigger test', () async {
    await driver?.runUnsynchronized(() async {
      await driver?.tap(find.byValueKey('build_button'));
      await Future.delayed(Duration(seconds: 1));
      expect(await driver?.getText(find.byText('Build Tip')), 'Build Tip');

      await driver?.tap(find.byValueKey('destroy_button'));
      await Future.delayed(Duration(seconds: 1));
      expect(await driver?.getText(find.byText('Destroy Tip')), 'Destroy Tip');
    });
  });
}
