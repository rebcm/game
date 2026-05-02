import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioServiceImpl {
  final AudioPlayer _audioPlayer;

  AudioServiceImpl(this._audioPlayer);

  Future<void> play(String assetPath) async {
    await _audioPlayer.setAsset(assetPath);
    _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future<void> setVolume(double volume) async {
    _audioPlayer.setVolume(volume);
  }

  Future<void> setPlaylist(List<String> assetPaths) async {
    final playlist = ConcatenatingAudioSource(
      children: assetPaths.map((path) => AudioSource.asset(path)).toList(),
    );
    await _audioPlayer.setAudioSource(playlist);
  }

  Future<void> fadeIn() async {
    await _audioPlayer.setVolume(0);
    _audioPlayer.play();
    for (double volume = 0; volume <= 1; volume += 0.1) {
      await _audioPlayer.setVolume(volume);
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  Future<void> fadeOut() async {
    for (double volume = 1; volume >= 0; volume -= 0.1) {
      await _audioPlayer.setVolume(volume);
      await Future.delayed(const Duration(milliseconds: 100));
    }
    await _audioPlayer.stop();
  }
}
