import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver?.close();
    }
  });

  test('Concorrência de escrita de chunks', () async {
    await driver?.requestData('test_chunk_concurrency');
    await driver?.waitUntilNoTransientCallbacks();
  });
}
