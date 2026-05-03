import 'package:just_audio/just_audio.dart';

class AudioCacheManager {
  final AudioPlayer _audioPlayer;

  AudioCacheManager(this._audioPlayer);

  void clearCache() {
    _audioPlayer.dispose();
  }
}
