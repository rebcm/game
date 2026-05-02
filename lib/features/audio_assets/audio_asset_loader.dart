import 'package:flutter/services.dart' show rootBundle;
import 'package:audioplayers/audioplayers.dart';

class AudioAssetLoader {
  Future<AudioPlayer> loadAudio(String filename) async {
    final player = AudioPlayer();
    await player.play(AssetSource('audio/.ogg'));
    return player;
  }
}
