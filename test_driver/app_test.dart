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
      final startTime = await driver!.getRenderObjectDiagnostics(find.byType('RebecaGame'), timeout: Duration(seconds: 10));
      final endTime = await driver!.getRenderObjectDiagnostics(find.byType('RebecaGame'), timeout: Duration(seconds: 10));
      final loadingTime = endTime[0].data!['renderTree']['children'][0]['stats']['firstPaint'] - startTime[0].data!['renderTree']['children'][0]['stats']['firstPaint'];
      print('Loading time: $loadingTime ms');
      await File('test_driver/loading_time.txt').writeAsString('$loadingTime');
    });
  });
}
