import 'package:game/services/telemetry/telemetry_service.dart';

class HintTracker {
  final TelemetryService _telemetryService;

  HintTracker(this._telemetryService);

  void onHintDisplayed(String hintId) {
    _telemetryService.trackHintDisplayed(hintId);
  }

  void onHintIgnored(String hintId) {
    _telemetryService.trackHintIgnored(hintId);
  }
}
