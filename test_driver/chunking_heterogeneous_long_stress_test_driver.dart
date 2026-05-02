import 'dart:async';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Chunking Heterogeneous Long Stress Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('long stress test', () async {
      final duration = const Duration(minutes: int.parse(const String.fromEnvironment('DURATION', defaultValue: '60')));
      final startTime = DateTime.now();
      while (DateTime.now().difference(startTime) < duration) {
        await driver.waitUntilNoTransientCallbacks();
        await Future.delayed(const Duration(seconds: 1));
      }
    });
  });
}
