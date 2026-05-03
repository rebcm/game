import 'package:flutter/material.dart';
import 'package:rebcm/services/audio/music_player.dart';

class MusicProvider with ChangeNotifier {
  final MusicPlayer _musicPlayer = MusicPlayer();

  Future<void> init() async {
    await _musicPlayer.init();
    notifyListeners();
  }

  Future<void> play() async {
    await _musicPlayer.play();
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

  Future<void> next() async {
    await _musicPlayer.next();
    notifyListeners();
  }

  Future<void> previous() async {
    await _musicPlayer.previous();
    notifyListeners();
  }

  Duration get currentPosition => _musicPlayer.currentPosition;

  Duration get duration => _musicPlayer.duration;

  bool get playing => _musicPlayer.playing;
}
