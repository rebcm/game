import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _audioPlayer;

  AudioService(this._audioPlayer);

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  Future<void> play(AudioPlayerSource source) async {
    await _audioPlayer.play(source, mode: PlayerMode.lowLatency);
  }
}
