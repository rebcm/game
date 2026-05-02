import 'package:just_audio/just_audio.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> play(String assetPath) async {
    await _audioPlayer.setAsset(assetPath);
    _audioPlayer.play();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future<void> setVolume(double volume) async {
    _audioPlayer.setVolume(volume);
  }

  Future<void> setLoopMode(bool loop) async {
    await _audioPlayer.setLoopMode(loop ? LoopMode.all : LoopMode.off);
  }
}
