import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  test('FPS Stress Test', () async {
    final driver = await FlutterDriver.connect();
    await driver.requestData('fps_stress_test');
    await driver.close();
  });
}
