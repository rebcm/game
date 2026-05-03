import 'package:rebcm/services/audio/audio_cache_manager.dart';
import 'package:just_audio/just_audio.dart';

class AudioManager {
  final AudioCacheManager _cacheManager = AudioCacheManager();

  Future<AudioPlayer> playSound(String assetPath) async {
    return await _cacheManager.getAudioPlayer(assetPath);
  }
}
