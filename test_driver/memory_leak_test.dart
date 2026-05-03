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
      // Navigate to the screen that initializes estado_jogo.dart
      await driver?.tap(find.byValueKey('init_estado_jogo'));

      // Wait for the estado_jogo.dart to be fully initialized
      await Future.delayed(const Duration(seconds: 5));

      // Measure memory usage before destroying estado_jogo.dart
      final beforeMemoryUsage = await driver?.requestData('getMemoryUsage');

      // Destroy estado_jogo.dart
      await driver?.tap(find.byValueKey('destroy_estado_jogo'));

      // Wait for the estado_jogo.dart to be fully destroyed
      await Future.delayed(const Duration(seconds: 5));

      // Measure memory usage after destroying estado_jogo.dart
      final afterMemoryUsage = await driver?.requestData('getMemoryUsage');

      // Compare the memory usage before and after destroying estado_jogo.dart
      print('Memory usage before destroying estado_jogo.dart: $beforeMemoryUsage');
      print('Memory usage after destroying estado_jogo.dart: $afterMemoryUsage');
    });
  });
}
