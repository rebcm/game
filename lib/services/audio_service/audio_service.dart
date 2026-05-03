import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _audioPlayer;

  AudioService(this._audioPlayer);

  Future<void> toggleShuffle() async {
    // Implement shuffle logic
    await _audioPlayer.toggleShuffle();
  }

  Future<void> toggleLoop() async {
    // Implement loop logic
    await _audioPlayer.toggleLoop();
  }

  Future<PlayerState> getCurrentState() async {
    return await _audioPlayer.getPlayerState();
  }
}
