import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/audio_service.dart';
import 'package:mockito/mockito.dart';

class MockAudioService extends Mock implements AudioService {}

void main() {
  group('Audio Edge Cases', () {
    late MockAudioService mockAudioService;

    setUp(() {
      mockAudioService = MockAudioService();
    });

    test('should handle loss of connection', () async {
      when(mockAudioService.playSound(any)).thenThrow(Exception('Connection lost'));
      expect(() async => mockAudioService.playSound('test_sound.mp3'), throwsException);
    });

    test('should handle silent mode', () async {
      when(mockAudioService.isMuted).thenReturn(true);
      expect(await mockAudioService.playSound('test_sound.mp3'), isFalse);
    });

    test('should handle interruption by phone calls', () async {
      when(mockAudioService.playSound(any)).thenThrow(Exception('Interrupted by phone call'));
      expect(() async => mockAudioService.playSound('test_sound.mp3'), throwsException);
    });

    test('should handle hardware permission denial', () async {
      when(mockAudioService.playSound(any)).thenThrow(Exception('Permission denied'));
      expect(() async => mockAudioService.playSound('test_sound.mp3'), throwsException);
    });
  });
}
