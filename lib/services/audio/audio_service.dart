import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioServiceImpl {
  final AudioPlayer _audioPlayer;

  AudioServiceImpl(this._audioPlayer);

  Future<void> init() async {
    await _audioPlayer.initialize();
  }

  Future<void> play() async {
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  Future<void> setMute(bool mute) async {
    await _audioPlayer.setVolume(mute ? 0 : 1);
  }

  double getVolume() {
    return _audioPlayer.volume;
  }

  bool isMuted() {
    return _audioPlayer.volume == 0;
  }
}
