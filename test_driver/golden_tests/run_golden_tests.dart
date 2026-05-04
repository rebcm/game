import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Golden Tests', () {
    test('run golden tests', () async {
      final FlutterDriver driver = await FlutterDriver.connect();
      await driver.requestData('run golden tests');
      await driver.close();
    });
  });
}
