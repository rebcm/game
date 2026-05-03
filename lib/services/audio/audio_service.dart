import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rebcm/services/audio/audio_cache_manager.dart';

class CustomAudioService {
  final AudioPlayer _audioPlayer;
  late AudioCacheManager _cacheManager;

  CustomAudioService() : _audioPlayer = AudioPlayer() {
    _cacheManager = AudioCacheManager(_audioPlayer);
  }

  Future<void> preloadAudioAssets(List<String> assetPaths) async {
    for (var path in assetPaths) {
      await _cacheManager.loadAsset(path);
    }
  }

  Future<void> playSound(String assetPath) async {
    await _cacheManager.playCachedAsset(assetPath);
  }
}
