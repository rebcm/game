import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Chunk Transition Stress Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver?.close();
    });

    test('Chunk transition stress test', () async {
      final chunkTransitionButton = find.byValueKey('chunk_transition_button');
      await driver?.waitFor(chunkTransitionButton);
      for (var i = 0; i < 100; i++) {
        await driver?.tap(chunkTransitionButton);
        await Future.delayed(const Duration(milliseconds: 50));
      }
    });
  });
}
