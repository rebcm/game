import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/audio_service.dart';

void main() {
  group('AudioService', () {
    test('initial connection status', () {
      final audioService = AudioService();
      expect(audioService.isConnected, true);
    });

    test('connection lost', () {
      final audioService = AudioService();
      audioService.onConnectionLost();
      expect(audioService.isConnected, false);
    });

    test('connection recovered', () {
      final audioService = AudioService();
      audioService.onConnectionLost();
      audioService.onConnectionRecovered();
      expect(audioService.isConnected, true);
    });
  });
}
