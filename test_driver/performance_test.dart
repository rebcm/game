import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Performance Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Undo/Redo Performance Test', () async {
      final undoButton = find.byTooltip('Undo');
      final redoButton = find.byTooltip('Redo');

      await driver.tap(undoButton);
      await driver.tap(redoButton);

      final rebuilds = await driver.getRenderObjectDiagnostics(find.byType('GameWidget'), timeout: Duration(seconds: 10));
      final latency = await driver.measurePerformance(find.byType('GameWidget'));

      print('Rebuilds: ${rebuilds.length}');
      print('Latency: ${latency.average}');
    });
  });
}

