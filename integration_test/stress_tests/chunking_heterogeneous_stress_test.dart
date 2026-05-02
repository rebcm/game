import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test_driver.dart';
import 'package:test/test.dart';

void main() {
  test('Chunking heterogeneous stress test', () async {
    final FlutterDriver driver = await FlutterDriver.connect();
    await driver.requestData('stress-test');
    await Future.delayed(Duration(minutes: 30));
    await driver.close();
  });
}
