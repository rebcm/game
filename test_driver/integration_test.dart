import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  test('Latency benchmark test', () async {
    final driver = await FlutterDriver.connect();
    await driver.requestData(''); // dummy request to ensure driver is connected
    await driver.close();
  });
}
