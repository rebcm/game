import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  test('D1/R2 integration test', () async {
    final driver = await FlutterDriver.connect();
    await driver.requestData('test_d1_r2_integration');
    await driver.close();
  });
}
