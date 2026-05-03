import 'package:just_audio/just_audio.dart';

class AudioManager {
  static final instance = AudioManager._();
  late AudioPlayer _audioPlayer;

  AudioManager._();

  Future<void> initialize() async {
    _audioPlayer = AudioPlayer();
  }

  Future<double> getMaxDecibels() async {
    // implement logic to get max decibels
    return 1.0;
  }

  Future<double> getCurrentVolume() async {
    // implement logic to get current volume
    return 0.5;
  }

  Future<void> playSound(String soundFile) async {
    await _audioPlayer.setAsset('assets/audio/optimized/sfx/$soundFile');
    _audioPlayer.play();
  }
}
