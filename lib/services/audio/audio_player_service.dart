import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isMuted = false;
  double _volume = 1.0;

  Future<void> init() async {
    await _audioPlayer.setVolume(_volume);
  }

  Future<void> play(String assetPath) async {
    await _audioPlayer.setAsset(assetPath);
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future<void> setVolume(double volume) async {
    _volume = volume;
    if (!_isMuted) {
      await _audioPlayer.setVolume(volume);
    }
  }

  Future<void> toggleMute() async {
    _isMuted = !_isMuted;
    await _audioPlayer.setVolume(_isMuted ? 0.0 : _volume);
  }

  double get volume => _volume;
  bool get isMuted => _isMuted;
}
