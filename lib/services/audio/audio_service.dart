import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioService {
  static final AudioService _instance = AudioService._();
  factory AudioService() => _instance;
  AudioService._();

  final AudioPlayer _audioPlayer = AudioPlayer();

  double _globalVolume = 1.0;

  double get globalVolume => _globalVolume;

  void setGlobalVolume(double volume) {
    _globalVolume = volume;
    _audioPlayer.setVolume(volume);
  }

  Future<void> playAudio(String assetPath) async {
    await _audioPlayer.setAsset(assetPath);
    _audioPlayer.setVolume(_globalVolume);
    await _audioPlayer.play();
  }
}
