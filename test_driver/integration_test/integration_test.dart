import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Renderização', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Verificar configurações de renderização', () async {
      final renderConfigApplied = await driver.waitFor(find.byValueKey('renderConfigApplied'));
      expect(renderConfigApplied, isNotNull);
    });

    test('Coletar performance após renderização', () async {
      final performanceData = await driver.traceAction(() async {
        await driver.tap(find.byValueKey('startPerformanceCollection'));
      });
      expect(performanceData, isNotEmpty);
    });
  });
}
import 'package:game/volume_test/volume_test.dart' as volume_test;

void main() {
  volume_test.main();
  // Other integration tests...
}
