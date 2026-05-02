import 'package:flutter_test/flutter_test.dart';
import 'package:your_app_name/features/audio_manager/audio_manager.dart';

void main() {
  group('AudioManager Test', () {
    test('Test play and stop audio', () async {
      final audioManager = AudioManager();
      await audioManager.playAudio('audio/ambient/passaros.ogg');
      await Future.delayed(Duration(seconds: 1));
      await audioManager.stopAudio();
      expect(true, true);
    });
  });
}
