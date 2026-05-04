import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  test('Frame timing test driver', () async {
    final FlutterDriver driver = await FlutterDriver.connect();
    await driver.requestData('start');
    await driver.close();
  });
}
