import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioServiceImpl {
  final AudioPlayer _audioPlayer;

  AudioServiceImpl(this._audioPlayer);

  Future<void> init() async {
    await _audioPlayer.setVolume(1.0);
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  Future<void> toggleMute() async {
    final currentVolume = _audioPlayer.volume;
    await _audioPlayer.setVolume(currentVolume == 0 ? 1.0 : 0.0);
  }

  double getVolume() => _audioPlayer.volume;
}
