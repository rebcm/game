import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  test('Integration test', () async {
    final driver = await FlutterDriver.connect();
    await driver.requestData('test_data');
    await driver.close();
  });
}
