import 'package:flutter/material.dart';
import 'package:rebcm/audio/audio_service_impl.dart';

class AudioManager with ChangeNotifier {
  final AudioServiceImpl _audioServiceImpl;

  AudioManager(this._audioServiceImpl);

  Future<void> play(String assetPath) async {
    await _audioServiceImpl.play(assetPath);
    notifyListeners();
  }

  Future<void> pause() async {
    await _audioServiceImpl.pause();
    notifyListeners();
  }

  Future<void> stop() async {
    await _audioServiceImpl.stop();
    notifyListeners();
  }

  Future<void> setVolume(double volume) async {
    await _audioServiceImpl.setVolume(volume);
    notifyListeners();
  }

  Future<void> setPlaylist(List<String> assetPaths) async {
    await _audioServiceImpl.setPlaylist(assetPaths);
    notifyListeners();
  }

  Future<void> fadeIn() async {
    await _audioServiceImpl.fadeIn();
    notifyListeners();
  }

  Future<void> fadeOut() async {
    await _audioServiceImpl.fadeOut();
    notifyListeners();
  }
}
