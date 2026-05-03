import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioCacheService with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void loadAudio(String assetPath) async {
    await _audioPlayer.setAsset(assetPath);
  }

  void disposeAudio() {
    _audioPlayer.dispose();
  }

  @override
  void dispose() {
    disposeAudio();
    super.dispose();
  }
}
