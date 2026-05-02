import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio/audio_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('AudioService', () {
    late AudioService audioService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      audioService = AudioService();
      await audioService.init();
    });

    test('initial volume is 1.0', () {
      expect(audioService.getVolume(), 1.0);
    });

    test('initial is not muted', () {
      expect(audioService.isMuted(), false);
    });

    test('toggle mute', () async {
      await audioService.toggleMute();
      expect(audioService.isMuted(), true);
      await audioService.toggleMute();
      expect(audioService.isMuted(), false);
    });

    test('set volume', () async {
      await audioService.setVolume(0.5);
      expect(audioService.getVolume(), 0.5);
    });
  });
}
