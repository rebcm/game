import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rebcm/services/audio/audio_cache_manager.dart';
import 'package:rebcm/utils/audio_asset_paths.dart';

class AudioService {
  final AudioCacheManager _cacheManager = AudioCacheManager();

  Future<void> init() async {
    await _cacheManager.preloadAudioAssets(AudioAssetPaths.sfxPaths);
    await _cacheManager.preloadAudioAssets(AudioAssetPaths.ambientPaths);
    await _cacheManager.preloadAudioAssets(AudioAssetPaths.musicPaths);
  }

  Future<AudioPlayer> playSfx(String path) async {
    return await _cacheManager.getAudioPlayer(path);
  }

  // Implement other audio service methods as needed
}
