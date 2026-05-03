import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/telemetry/telemetry_service.dart';

void main() {
  group('TelemetryService', () {
    test('trackHintDisplayed prints hint displayed message', () {
      final telemetryService = TelemetryService();
      expect(() => telemetryService.trackHintDisplayed('test_hint'), prints('Hint displayed: test_hint'));
    });

    test('trackHintIgnored prints hint ignored message', () {
      final telemetryService = TelemetryService();
      expect(() => telemetryService.trackHintIgnored('test_hint'), prints('Hint ignored: test_hint'));
    });
  });
}
