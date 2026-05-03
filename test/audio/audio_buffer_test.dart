import 'package:flutter_test/flutter_test.dart';
import 'package:game/audio/audio_buffer.dart';

void main() {
  group('AudioBuffer', () {
    late AudioBuffer audioBuffer;

    setUp(() {
      audioBuffer = AudioBuffer();
    });

    test('initial state', () {
      expect(audioBuffer.buffer, isEmpty);
      expect(audioBuffer.isConnected, isTrue);
    });

    test('add audio data when connected', () {
      audioBuffer.addAudioData([1, 2, 3]);
      expect(audioBuffer.buffer, [1, 2, 3]);
    });

    test('does not add audio data when disconnected', () {
      audioBuffer.onConnectionLost();
      audioBuffer.addAudioData([1, 2, 3]);
      expect(audioBuffer.buffer, isEmpty);
    });

    test('reconnects after connection loss', () async {
      audioBuffer.onConnectionLost();
      expect(audioBuffer.isConnected, isFalse);
      await Future.delayed(Duration(seconds: 6));
      expect(audioBuffer.isConnected, isTrue);
    });
  });
}
