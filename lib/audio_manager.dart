import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static AudioManager? _instance;
  double _volume = 1.0;
  List<AudioPlayer> _activePlayers = [];

  factory AudioManager.instance() {
    _instance ??= AudioManager._();
    return _instance!;
  }

  AudioManager._();

  double get volume => _volume;

  Future<void> setVolume(double volume) async {
    _volume = volume;
    await Future.wait(_activePlayers.map((player) => player.setVolume(volume)));
  }

  // Hypothetical method to add player
  void addPlayer(AudioPlayer player) {
    _activePlayers.add(player);
  }
}
