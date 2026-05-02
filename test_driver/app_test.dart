import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Rebeca Game', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver!.close();
      }
    });

    test('measure loading time', () async {
      final loadingTime = await driver!.measure(
        () async {
          await driver!.waitFor(find.text('Rebeca Game'));
        },
      );
      print('Loading time: $loadingTime');
      await File('test_driver/loading_time.txt').writeAsString(loadingTime.toString());
    });
  });
}
