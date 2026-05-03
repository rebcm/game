import 'package:flutter_test/flutter_test.dart';
import 'package:audio_session/audio_session.dart';
import 'package:game/audio_management/audio_session_manager.dart';

void main() {
  test('AudioSessionManager manages audio session correctly', () async {
    final audioSession = await AudioSession.instance;
    final audioSessionManager = AudioSessionManager(audioSession);
    await audioSessionManager.manageAudioSession();
    expect(await audioSession.setActive(true), isTrue);
  });
}
