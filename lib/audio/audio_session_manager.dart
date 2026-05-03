import 'package:flutter/services.dart';
import 'package:audio_session/audio_session.dart';

class AudioSessionManager {
  static final AudioSessionManager _instance = AudioSessionManager._();

  factory AudioSessionManager() => _instance;

  AudioSessionManager._();

  Future<void> configureAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      androidAudioAttributes: AndroidAudioAttributes(
        contentType: AndroidAudioContentType.music,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.game,
      ),
      avAudioSessionCategory: AVAudioSessionCategory.playback,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
      avAudioSessionMode: AVAudioSessionMode.defaultMode,
      iosCategory: IosCategory.playback,
      iosCategoryOptions: IosCategoryOptions.duckOthers,
    ));
  }

  Future<void> setActive(bool active) async {
    final session = await AudioSession.instance;
    await session.setActive(active);
  }
}
