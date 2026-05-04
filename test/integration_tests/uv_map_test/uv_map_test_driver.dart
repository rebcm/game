import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  test('UV Map Test Driver', () async {
    final driver = await FlutterDriver.connect();
    await driver.runUnsynchronized(() async {
      await driver.requestData('wait_for_uv_map');
    });
    await driver.close();
  });
}
