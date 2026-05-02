import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'audio_manager.dart';

class AudioProvider with ChangeNotifier {
  final AudioManager _audioManager = AudioManager();

  Future<void> playMusic(String assetPath) async {
    await _audioManager.playMusic(assetPath);
    notifyListeners();
  }

  Future<void> playSfx(String assetPath) async {
    await _audioManager.playSfx(assetPath);
    notifyListeners();
  }

  Future<void> stopMusic() async {
    await _audioManager.stopMusic();
    notifyListeners();
  }

  Future<void> stopSfx() async {
    await _audioManager.stopSfx();
    notifyListeners();
  }
}
