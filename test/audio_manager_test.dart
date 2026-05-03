import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/managers/audio_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AudioManager', () {
    test('playSound returns an AudioPlayer instance', () async {
      final audioManager = AudioManager();
      final assetPath = 'assets/audio/optimized/sfx/block_break.mp3';
      final player = await audioManager.playSound(assetPath);
      expect(player, isNotNull);
    });
  });
}
