import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('IO Latency Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Cold Start vs Cached', () async {
      final coldStartTimer = await driver.traceAction(() async {
        await driver.requestData('coldStart');
      });
      final cachedLoadTimer = await driver.traceAction(() async {
        await driver.requestData('cachedLoad');
      });

      print('Cold Start Duration: ${coldStartTimer.duration.inMilliseconds} ms');
      print('Cached Load Duration: ${cachedLoadTimer.duration.inMilliseconds} ms');
    });
  });
}
