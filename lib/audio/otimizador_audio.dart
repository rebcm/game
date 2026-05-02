import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

class OtimizadorAudio {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> preloadAudio(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    await _audioPlayer.setSourceBytes(data.buffer.asUint8List());
    await _audioPlayer.stop();
  }

  static Future<void> playAudio(String assetPath) async {
    await _audioPlayer.setSource(AssetSource(assetPath));
    await _audioPlayer.resume();
  }

  static Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  static Future<void> releaseResources() async {
    await _audioPlayer.dispose();
  }
}
