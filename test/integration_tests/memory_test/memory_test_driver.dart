import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      await driver?.close();
    }
  });

  test('memory test driver', () async {
    await driver?.runUnsynchronized(() async {
      await driver?.tap(find.byText('Build'));
      await Future.delayed(Duration(seconds: 2)); // wait for GC
    });
  });
}
