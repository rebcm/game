import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rebcm/services/audio/audio_cache_manager.dart';

class AudioService {
  late AudioPlayer _audioPlayer;
  late AudioCacheManager _audioCacheManager;

  Future<void> init() async {
    _audioPlayer = AudioPlayer();
    _audioCacheManager = AudioCacheManager(_audioPlayer);
    await _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse('')));
  }

  Future<void> preloadAudio(String assetPath) async {
    await _audioCacheManager.preloadAudio(assetPath);
  }

  Future<void> playAudio(String assetPath) async {
    await _audioCacheManager.playCachedAudio(assetPath);
  }

  void dispose() {
    _audioCacheManager.dispose();
    _audioPlayer.dispose();
  }
}
