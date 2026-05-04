import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Stress Test Driver for Retention of Closures and Streams', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver?.close();
    });

    test('Validate retention after unloading chunks', () async {
      await driver?.tap(find.text('Load Chunk'));
      await driver?.tap(find.text('Unload Chunk'));
      expect(await driver?.getText(find.text('Memory Leak Detected')), isNot('Memory Leak Detected'));
    });

    test('Validate stream listeners after unloading chunks', () async {
      await driver?.tap(find.text('Load Chunk with Stream'));
      await driver?.tap(find.text('Unload Chunk with Stream'));
      expect(await driver?.getText(find.text('Stream Listener Leak Detected')), isNot('Stream Listener Leak Detected'));
    });
  });
}
