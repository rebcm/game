import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class GerenciadorAudio {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> carregarAudio(String path) async {
    await _audioPlayer.setSource(AssetSource(path));
  }

  Future<void> reproduzirAudio(String path) async {
    await carregarAudio(path);
    await _audioPlayer.resume();
  }

  Future<void> pararAudio() async {
    await _audioPlayer.stop();
  }

  Future<void> pausarAudio() async {
    await _audioPlayer.pause();
  }
}
