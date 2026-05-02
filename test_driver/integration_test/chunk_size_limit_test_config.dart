import 'package:flutter_driver/flutter_driver.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      await driver!.close();
    }
  });

  test('Chunk Size Limit Test', () async {
    await driver!.requestData('test_chunk_size_limit');
  });
}
