import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isMuted = false;
  double _volume = 1.0;

  Future<void> init() async {
    await _audioPlayer.setVolume(_volume);
  }

  Future<void> play() async {
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> setVolume(double volume) async {
    _volume = volume;
    if (!_isMuted) {
      await _audioPlayer.setVolume(volume);
    }
  }

  Future<void> toggleMute() async {
    _isMuted = !_isMuted;
    if (_isMuted) {
      await _audioPlayer.setVolume(0.0);
    } else {
      await _audioPlayer.setVolume(_volume);
    }
  }

  double getVolume() => _volume;
  bool isMuted() => _isMuted;
}
