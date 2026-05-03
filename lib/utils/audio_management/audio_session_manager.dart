import 'package:audio_session/audio_session.dart';

class AudioSessionManager {
  final AudioSession _audioSession;

  AudioSessionManager(this._audioSession);

  Future<void> manageAudioSession() async {
    await _audioSession.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playback,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.music,
        usage: AndroidAudioUsage.media,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
    ));
  }

  Future<void> setActive(bool active) async {
    await _audioSession.setActive(active);
  }
}
