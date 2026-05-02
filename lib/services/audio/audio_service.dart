import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rebcm/services/audio/audio_cache_manager.dart';

class CustomAudioService {
  final AudioPlayer _audioPlayer;
  late AudioCacheManager _audioCacheManager;

  CustomAudioService(this._audioPlayer) {
    _audioCacheManager = AudioCacheManager(_audioPlayer);
  }

  Future<void> playSound(String assetPath) async {
    await _audioCacheManager.playCachedAsset(assetPath);
  }
}
