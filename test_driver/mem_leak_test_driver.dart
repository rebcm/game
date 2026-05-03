import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Memory Leak Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver?.close();
    });

    test('Measure memory usage before and after destroying estado_jogo.dart', () async {
      // Implement the logic to measure memory usage before and after destroying estado_jogo.dart
      // Use driver!.requestData() or other methods to interact with the app and measure memory
    });
  });
}
