import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  test('global shortcuts test', () async {
    final driver = await FlutterDriver.connect();
    await driver.runUnsynchronized(() async {
      await driver.requestData('global_shortcuts_test');
    });
    await driver.close();
  });
}
