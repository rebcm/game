import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  test('IO Latency Test', () async {
    final driver = await FlutterDriver.connect();
    await driver.waitUntilFirstFrameRasterized();

    final latency = await driver.measure(() async {
      // Perform some IO operation
    });

    print('IO Latency: $latency');
    await driver.close();
  });
}
