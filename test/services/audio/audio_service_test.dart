import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio/audio_service.dart';

void main() {
  group('AudioService', () {
    test('should be a singleton', () {
      final instance1 = AudioService();
      final instance2 = AudioService();
      expect(instance1, instance2);
    });

    test('should set and get global volume', () {
      final audioService = AudioService();
      audioService.setGlobalVolume(0.5);
      expect(audioService.globalVolume, 0.5);
    });
  });
}
