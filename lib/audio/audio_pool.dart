import 'package:just_audio/just_audio.dart';

class AudioPool {
  final _players = <String, AudioPlayer>{};

  Future<void> play(String audioPath) async {
    if (_players.containsKey(audioPath)) {
      await _players[audioPath]!.play();
    } else {
      final player = AudioPlayer();
      await player.setAsset(audioPath);
      _players[audioPath] = player;
      await player.play();
    }
  }

  Future<void> stop(String audioPath) async {
    if (_players.containsKey(audioPath)) {
      await _players[audioPath]!.stop();
    }
  }

  void dispose() {
    _players.values.forEach((player) => player.dispose());
  }
}
