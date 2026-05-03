import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Memory Leak Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver!.close();
      }
    });

    test('Memory leak detection', () async {
      await driver!.requestData('gc'); // Request GC to clean up
      await Future.delayed(Duration(seconds: 2)); // Wait for GC to complete

      final timeline = await driver!.traceAction(() async {
        // Perform actions to test for memory leaks
        await driver!.tap(find.byTooltip('Build'));
        await Future.delayed(Duration(seconds: 1)); // Wait for the action to complete
      });

      final memoryUsage = await driver!.requestData('memoryUsage');
      print('Memory usage: $memoryUsage');

      // Add assertions based on the memory usage
      expect(memoryUsage, isNotNull);
    });
  });
}
