import 'package:flutter/material.dart';
import 'package:rebcm/services/audio/music_player.dart';

class MusicProvider with ChangeNotifier {
  final MusicPlayer _musicPlayer = MusicPlayer();

  Future<void> init() async {
    await _musicPlayer.init();
    notifyListeners();
  }

  Future<void> playSequential() async {
    await _musicPlayer.playSequential();
    notifyListeners();
  }

  Future<void> playShuffle() async {
    await _musicPlayer.playShuffle();
    notifyListeners();
  }

  Future<void> pause() async {
    await _musicPlayer.pause();
    notifyListeners();
  }

  Future<void> stop() async {
    await _musicPlayer.stop();
    notifyListeners();
  }

  Duration? getCurrentPosition() {
    return _musicPlayer.getCurrentPosition();
  }

  Duration? getDuration() {
    return _musicPlayer.getDuration();
  }

  bool get playing => _musicPlayer.playing;
}
