import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._();
  final List<AudioPlayer> _players = [];

  factory AudioManager.instance() => _instance;

  AudioManager._();

  void registerPlayer(AudioPlayer player) => _players.add(player);

  Future<void> setVolume(double volume) async {
    for (var player in _players) {
      await player.setVolume(volume);
    }
  }
}
