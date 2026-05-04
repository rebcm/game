import 'package:flutter_test/flutter_test.dart';
import 'package:game/audio_manager.dart';

void main() {
  group('AudioManager', () {
    test('Deve pausar a música quando a conexão for perdida', () async {
      // Arrange
      final audioManager = AudioManager();

      // Act
      await audioManager.pauseMusic();

      // Assert
      expect(audioManager.isMusicPlaying(), false);
    });
  });
}
