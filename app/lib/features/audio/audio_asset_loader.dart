import 'package:flutter/services.dart' show rootBundle;
import 'package:audioplayers/audioplayers.dart';

class AudioAssetLoader {
  final AudioPlayer _audioPlayer;

  AudioAssetLoader(this._audioPlayer);

  Future<void> loadAudio(String assetPath) async {
    // Check if compressed audio exists
    try {
      await rootBundle.load('assets/audio_compressed/$assetPath.ogg');
      await _audioPlayer.setSource(AssetSource('assets/audio_compressed/$assetPath.ogg'));
    } catch (e) {
      // Fallback to original asset if compressed version doesn't exist
      await _audioPlayer.setSource(AssetSource('assets/$assetPath'));
    }
  }
}
