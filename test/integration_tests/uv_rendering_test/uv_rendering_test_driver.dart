import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  test('UV rendering test driver', () async {
    final driver = await FlutterDriver.connect();
    await driver.runUnsynchronized(() async {
      await driver.waitUntilNoTransientCallbacks();
    });
    await driver.close();
  });
}
