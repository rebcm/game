import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Rebuild Performance Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Undo/Redo rebuild performance', () async {
      final undoButton = find.byTooltip('Undo');
      final redoButton = find.byTooltip('Redo');

      // Perform Undo/Redo operations and measure rebuilds
      await driver.waitFor(undoButton);
      await driver.tap(undoButton);
      await driver.waitFor(redoButton);
      await driver.tap(redoButton);

      // Get the number of rebuilds
      final rebuildCount = await driver.getRenderObjectDiagnostics(find.byType('RebecaWorld'), timeout: Duration(seconds: 10));

      // Check if the number of rebuilds is within the acceptable limit
      expect(rebuildCount, lessThan(5));
    });
  });
}
