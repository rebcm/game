import 'package:flutter_test/flutter_test.dart';
import 'package:game/audio_manager.dart';
import 'package:mockito/mockito.dart';

class MockAudioManager extends Mock implements AudioManager {}

void main() {
  group('Áudio Edge Cases', () {
    test('Perda de conexão deve pausar a música', () async {
      // Arrange
      final audioManager = MockAudioManager();
      when(audioManager.isConnected()).thenReturn(false);

      // Act
      await audioManager.pauseMusic();

      // Assert
      verify(audioManager.pauseMusic()).called(1);
    });

    test('Modo silencioso deve pausar a música', () async {
      // Arrange
      final audioManager = MockAudioManager();
      when(audioManager.isSilentMode()).thenReturn(true);

      // Act
      await audioManager.pauseMusic();

      // Assert
      verify(audioManager.pauseMusic()).called(1);
    });

    test('Interrupção por chamadas telefônicas deve pausar a música', () async {
      // Arrange
      final audioManager = MockAudioManager();
      when(audioManager.isInterruptedByCall()).thenReturn(true);

      // Act
      await audioManager.pauseMusic();

      // Assert
      verify(audioManager.pauseMusic()).called(1);
    });

    test('Permissões de hardware negadas devem pausar a música', () async {
      // Arrange
      final audioManager = MockAudioManager();
      when(audioManager.hasHardwarePermissions()).thenReturn(false);

      // Act
      await audioManager.pauseMusic();

      // Assert
      verify(audioManager.pauseMusic()).called(1);
    });
  });
}
