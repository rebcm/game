import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Integration Tests', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Test 1', () async {
      // Implementação do teste 1
    });

    test('Test 2', () async {
      // Implementação do teste 2
    });
  });
}
